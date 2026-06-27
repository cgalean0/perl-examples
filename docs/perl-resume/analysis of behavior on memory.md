Consideremos un ejemplo de código extremadamente pequeño en Perl que involucre un _closure_, un _scratchpad_ local (el stack/pad de la subrutina) y estructuras en el Heap:

Perl code
```perl
sub crear {
    my $x = 42;
    return sub { $x };
}
my $f = crear();
```

A continuación, se detalla el mapa de memoria (representando el intérprete de Perl) justo en el momento en que `crear()` ya terminó de ejecutarse, pero su variable léxica sobrevive en el Heap a través de la referencia devuelta en `$f`.
### Representación del Stack y el Heap

```
==================================================================================
 STACK DE CONTEXTOS (cxstack) & MAIN PAD
==================================================================================
 +-------------------------------------------------------------+
 [ cxstack (Llamadas activas)                                  ]
 +-------------------------------------------------------------+
 |  A nivel de ejecución, crear() ya hizo POP.                 |
 |  El flujo de control volvió al bloque principal ('main').   |
 +-------------------------------------------------------------+

 [ Scratchpad del Main (Variables Léxicas Globales del Script) ]
 +---------+------------------+
 | Variable| Puntero al Heap  |
 +---------+------------------+
 |   $f    |   ------------+  |  <-- Copia el Coderef (CV) devuelto por crear()
 +---------+---------------|--+
                           |
                           v
==================================================================================
 MEMORIA HEAP (Estructuras de la API de C de Perl: SV, AV, HV, CV)
==================================================================================
                           |
                           |  (Apunta al cuerpo de la subrutina anónima)
                           v
              +----------------------------+
              |      CV (Code Value)       |  <-- La función anónima real
              +----------------------------+
              | Ref Count: 1               |
              | FLAGS    : SVt_PVCV        |
              | PADLIST  : ------------+   |  <-- Mantiene vivo el entorno léxico
              +------------------------|---+
                                       |
                                       v
                     +---------------------------------------+
                     |    SCRATCHPAD / PADLIST (En el Heap)  |
                     +---------------------------------------+
                     | Este Pad pertenecía a crear() cuando  |
                     | estaba en el Stack, pero migró al     |
                     | Heap porque su Ref Count > 0.          |
                     |                                       |
                     | Slot [1]: (Nombre: $x)                |
                     |   Puntero al SV: ----------+          |
                     +----------------------------|----------+
                                  +---------------+
                                  |
                                  v
					+----------------------------+
					|     SV (Scalar Value)      | <-- El dato real
					+----------------------------+
					| Ref Count: 1               | (Apuntado solo por el
					| FLAGS    : SVt_IV (Integer)|  Scratchpad guardado)
					| VALUE    : 42              |
					+----------------------------+
```

### Análisis del Layout

1. **El Contexto de Ejecución (Stack):** El `cxstack` ya no tiene el _frame_ de `crear()`. Sin embargo, las variables que se declararon dentro de ella no desaparecieron. En C o Java (sin _closures_), al destruir el _frame_, `$x` se habría volatilizado.
    
2. **El Ciclo de Vida del Pad:** El _Scratchpad_ que contenía a `$x` se desatrapó del flujo secuencial de la pila. El `CV` (la función anónima que guardamos en `$f`) tiene un puntero hacia ese Pad específico.
    
3. **El Grado de Indirección en el Heap:** Observa que el Pad del Main no apunta al número `42` de forma directa, sino al contenedor `$f` (`CV`), el cual a su vez encadena el acceso a `$x` (`SV`) a través del mapa de variables capturadas. El Garbage Collector de Perl limpia la memoria de forma exacta en el momento en que destruyas `$f` (haciendo `undef $f;`), ya que eso bajará el contador del `CV` a 0, desencadenando la caída en dominó de los contadores del Pad y finalmente del `SV` que aloja al entero `42`.