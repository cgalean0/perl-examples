Un **closure** (o cerradura lingüística) es una estructura de datos de primera clase que combina una función junto con el **entorno léxico** en el que fue declarada.

En términos más simples: un closure es una función que "recuerda" y puede acceder a las variables de su scope externo, incluso después de que la función externa que creó ese scope haya terminado su ejecución y su _stack frame_ haya sido destruido.

Para entender cómo se construye un closure, debemos analizar las tres condiciones que se deben cumplir a nivel de diseño de lenguajes:

1. **Funciones de primera clase:** El lenguaje debe permitir tratar a las funciones como variables (poder pasarlas como argumentos, retornarlas desde otras funciones o asignarlas a una variable).
2. **Scope Léxico (o estático):** El ámbito de una variable se determina en tiempo de compilación según la posición física en el código fuente, no por la cadena de llamadas en tiempo de ejecución.
3. **Persistencia del entorno en el Heap:** El lenguaje debe ser capaz de mover o mantener las variables locales en la memoria Heap si detecta que una función interna aún mantiene referencias hacia ellas.
    
### Análisis de un ejemplo (en Perl / pseudocódigo)
Analicemos el flujo matemático y de memoria de este patrón clásico:
Perl code
```perl
sub crear_multiplicador {
    my ($factor) = @_;                # Variable léxica local
    return sub { my ($n) = @_; return $n * $factor }; 
}

my $duplicar = crear_multiplicador(2);
print $duplicar->(5); # Imprime 10
```

#### ¿Qué ocurre en la memoria bajo el capó?
1. **Invocación:** Se llama a `crear_multiplicador(2)`. Se abre un scope y la variable `$factor` toma el valor `2`.
2. **Retorno:** La función retorna una subrutina anónima que encapsula la operación `$n * $factor`. En un lenguaje sin closures (como C clásico), al retornar, la variable `$factor` moriría porque el _stack frame_ se libera.
3. **Captura en el Heap:** Como el intérprete detecta que la función anónima interna usa `$factor`, el contador de referencias de ese entorno no baja a cero. El entorno se "cierra" (de ahí _closure_) alrededor de la función.
4. **Ejecución diferida:** Cuando ejecutas `$duplicar->(5)`, se evalúa la función interna. El parámetro `$n` es `5`, y `$factor` se recupera del entorno guardado en el Heap, que sigue siendo `2`.
### Conexión entre Perspectivas

- **Perspectiva Matemática / Lógica:** En el cálculo lambda, un closure es la conversión de una _expresión abierta_ (una función con variables libres que no están ligadas a sus parámetros) en una _expresión cerrada_, proveyendo una ligadura (_binding_) para cada una de esas variables libres desde el contexto de definición.
    
- **Perspectiva Computacional:** Es un mecanismo de encapsulamiento primitivo. De hecho, un closure es matemáticamente equivalente a un objeto con un solo método. Un objeto es estado (atributos) con comportamiento (métodos); un closure es comportamiento (función) con estado encapsulado (el entorno léxico capturado).