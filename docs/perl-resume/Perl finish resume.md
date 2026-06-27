- [[analysis of vars in loops]]
- [[closures]]
- [[analysis of behavior on memory]]
## Lista de ejemplos prácticos para la demo

### Tipos y contexto

1. Mismo array en contexto escalar vs. lista — mostrar que devuelve cosas distintas
2. Coerción implícita — operar string numérico con operadores aritméticos vs. string

### Variables y scope

3. `my` vs. `local` — demostrar que `local` afecta funciones llamadas y `my` no
4. Closure con contador — variable que sobrevive a su scope

### Paso de parámetros y aliasing

5. `@_` como alias — modificar un argumento dentro de la función y ver el efecto afuera
6. `$_` en `for` — iterar sin variable explícita y modificar el array original
7. Aplanamiento de arrays al pasar como argumentos

### Referencias y memoria

8. Referencia circular — demostrar el leak con un hash que se apunta a sí mismo
9. Solución con `weaken`

### Regex

10. Extraer datos de texto con `=~` y grupos de captura
11. Sustitución global con `s///g` sobre un string

### Funciones de orden superior

12. `map` y `grep` encadenados sobre una lista
13. Closure como fábrica de funciones — `make_multiplicador`

### OOP

14. Clase manual con `bless` — constructor, atributo, método
15. Herencia simple — subclase que sobreescribe un método y llama al padre con `SUPER`

### Concurrencia

16. Fork simple — padre e hijo haciendo tareas distintas