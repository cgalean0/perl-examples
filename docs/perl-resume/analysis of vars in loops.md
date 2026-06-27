En Perl, la variable de control de un bucle `for` (o `foreach`, que son alias sintácticos) maneja el scope y la memoria de una manera muy particular y única si la comparamos con lenguajes como C, Java o Python.

> La respuesta técnica es: **No es ninguna de las dos opciones tradicionales. Es un alias implícito y temporal (_aliasing_) que se redefine en cada iteración.**

Vamos a analizar minuciosamente qué ocurre bajo el capó a nivel de AST, Scope y Memoria (Heap) para entender este comportamiento.

### 1. El mecanismo real: Léxica por defecto y Aliasing

Cuando escribís `for $i (1..10) {...}`, Perl aplica dos reglas de diseño críticas de forma automática:

- **Scope Léxico Forzado:** Aunque no hayas escrito la palabra clave `my`, Perl trata a la variable `$i` como si fuera local y exclusiva del bloque del `for`. Si ya existía una variable llamada `$i` fuera del bucle, Perl la "salva" temporalmente en el _Context Stack_ y la restaura intacta al terminar el bucle.
    
- **Aliasing Implícito (Paso por referencia):** `$i` no almacena una copia del valor de la lista, sino que se convierte en un **alias directo (un puntero de C a nivel del intérprete)** al elemento actual de la lista.
#### La prueba de mutabilidad

Debido a que es un alias y no una copia ni una variable común reemplazando valores planos, **si modificás `$i` dentro del bucle, modificás la estructura original de la lista** (siempre y cuando la lista permita modificaciones).

Perl code
```perl
my @lista = (1, 2, 3);

for $i (@lista) {
    $i *= 2; # Multiplica el alias directo
}

# @lista ahora contiene: (2, 4, 6)
```

### 2. ¿Qué pasa en la memoria en cada iteración?

Si analizamos el intérprete de Perl, la lista `(1..10)` o `@lista` reside en el Heap como un conjunto de estructuras `SV` (Scalar Values).

En lugar de destruir y crear un contenedor `SV` para `$i` en cada iteración, o de copiar los bytes del entero dentro de un mismo `SV`, Perl simplemente **mueve el puntero del alias**.

```text
Iteración 1:
   [ Pad del for: $i ] ------------> [ SV en Heap: 1 ]
                                      [ SV en Heap: 2 ]
                                      [ SV en Heap: 3 ]

Iteración 2:
   [ Pad del for: $i ] ----------+
                                 |
                                 |   
                                 |      [ SV en Heap: 1 ]
                                 +----> [ SV en Heap: 2 ]
                                        [ SV en Heap: 3 ]
```

El _Scratchpad_ (Pad) asignado a la ejecución del bucle mantiene el nombre `$i`, pero el operando interno (el nodo del _optree_ del intérprete) redirige la dirección de memoria de `$i` para que apunte directamente al `SV` del elemento correspondiente en cada paso del ciclo.

### 3. El peligro de los Closures dentro de un `for`

Este comportamiento genera un efecto colateral clásico y avanzado cuando combinás un bucle `for` con funciones anónimas (_closures_). Al ser una variable léxica que cambia su ligadura (_binding_) en cada iteración, si capturás `$i` dentro de una función, cada función recordará **el elemento de la iteración específica**, no el último valor del bucle.

Perl code
```perl
my @funciones;

for $i (1..3) {
    push @funciones, sub { print "$i\n" };
}

$funciones[0]->(); # Imprime 1
$funciones[1]->(); # Imprime 2
$funciones[2]->(); # Imprime 3
```

> _Nota de contraste:_ En JavaScript antiguo (usando `var`), el código equivalente habría impreso `3` en todas las llamadas porque la variable era la misma reemplazando su valor plano en el mismo scope. Perl, al forzar un comportamiento léxico y de aliasing único por iteración, garantiza que cada closure capture la referencia exacta del elemento que le correspondía en ese instante.


