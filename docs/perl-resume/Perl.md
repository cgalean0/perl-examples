Referencias oficiales: -> [Perl.org](http://perl.org/)
- [Perl Cheat Sheet](https://perldoc.perl.org/perlcheat)
- [Perl Security](https://perldoc.perl.org/perlsec)
- [Perl Threads](https://perldoc.perl.org/perlthrtut)
- [Perl Vars](https://perldoc.perl.org/perlvar)
- [Perl Manual](https://perldoc.perl.org/perl)
# Perl — Guía conceptual para tu exposición

Vamos por partes. Antes de darte información, quiero que esta guía te sirva para _entender_ Perl, no solo recitarlo.

---

## ¿Qué es Perl y por qué existe?

Perl nació en 1987 de la mano de **Larry Wall**, quien tenía formación en lingüística. Eso no es un dato trivial — moldea toda la filosofía del lenguaje.

Wall quería una herramienta que llenara el hueco entre los shell scripts (demasiado limitados) y C (demasiado verboso para tareas de texto/sistema). El resultado fue un lenguaje con un lema famoso:

> **"There's more than one way to do it" (TMTOWTDI)**

Compará eso con Python, que dice exactamente lo opuesto. ¿Por qué creés que dos lenguajes de scripting toman filosofías tan opuestas? ¿Qué implica eso para el programador?

---

## Paradigma(s) de Perl

Perl es **multiparadigma**, pero con una identidad propia:

- **Imperativo/procedimental** — su base
- **Orientado a objetos** — soportado, pero de forma no nativa (se construye sobre referencias y `bless`)
- **Funcional** — tiene `map`, `grep`, `sort` con bloques, closures reales
- **Orientado a texto / procesamiento de datos** — aquí es donde _realmente_ brilla

La pregunta clave para tu exposición: **¿Perl es multiparadigma por diseño o por acumulación?** ¿Cuál es la diferencia?

---

## Tipado y semántica de variables

### El sistema de tipos

Perl usa **tipado dinámico y débil**. Pero tiene algo único: el tipo no está en el valor, está en el **contexto de evaluación**.

```
$escalar   # Un solo valor
@array     # Lista de valores
%hash      # Pares clave-valor
```

Los **sigils** (`$`, `@`, `%`) no son solo decoración — indican qué tipo de dato esperás en ese contexto. Esto es **tipado por contexto**, un concepto que vale la pena explorar.

### Contexto escalar vs. lista

Este es el concepto más distintivo de Perl. La misma expresión puede evaluarse de forma completamente diferente:

```perl
my @arr = (1, 2, 3, 4, 5);

# Contexto lista:
my @copia = @arr;       # copia los elementos

# Contexto escalar:
my $n = @arr;           # devuelve el tamaño del arr
```

**Pregunta para vos:** ¿Qué ventajas y qué peligros ves en un sistema donde el comportamiento depende del contexto? ¿Se te ocurre algún bug clásico que esto podría causar?

---

## Fortaleza central: Expresiones regulares

Las regex en Perl no son una biblioteca externa — son **parte del lenguaje**. Están integradas en la sintaxis:

```
=~   operador de matching
s/// sustitución
m/// matching
```

Perl fue tan influyente en este aspecto que el estándar de regex que usamos hoy en Python, Java, JavaScript... se llama **PCRE: Perl Compatible Regular Expressions**.

Reflexión para tu exposición: ¿Qué dice sobre un lenguaje el hecho de que su sistema de pattern matching se volvió el estándar de la industria?

---

## Manejo de memoria

Perl usa **garbage collection por conteo de referencias**. Esto es importante porque introduce un problema conocido:

- ¿Qué pasa cuando dos estructuras se referencian mutuamente?
- ¿Cómo se rompe ese ciclo?

Perl provee `weaken()` del módulo `Scalar::Util`. ¿Recordás de tus estudios de Java o de Paradigmas algún mecanismo similar para ciclos de referencias?

---

## OOP en Perl — El caso interesante

La OOP de Perl es famosa por ser "opt-in" y construida manualmente:

- No hay una keyword `class` nativa (hasta Perl moderno, 5.38+)
- Los objetos son **referencias a estructuras de datos** a las que se les hace `bless` para asociarlas a un paquete (namespace)
- La herencia se declara vía `@ISA`

```perl
# pseudoidea, no código completo:
package Animal;
sub new { bless { nombre => $_[1] }, $_[0] }
sub hablar { ... }

package Perro;
our @ISA = ('Animal');
sub hablar { print "Guau\n" }
```

**¿Qué paradigma de diseño te recuerda esto?** ¿Qué diferencia hay entre una clase en Java y un paquete + bless en Perl?

---

## CPAN — El ecosistema

Perl tiene el **CPAN (Comprehensive Perl Archive Network)**, uno de los repositorios de módulos más antiguos y grandes de la historia del software. Fue pionero del concepto que luego adoptaron npm, pip, gem, etc.

---

## Casos de uso históricos y actuales

|Área|¿Por qué Perl?|
|---|---|
|Administración de sistemas Unix|Manipulación de texto, pipes, archivos|
|Bioinformática|Procesamiento de secuencias genéticas (GenBank usa Perl)|
|Web (CGI)|Fue _el_ lenguaje web antes de PHP/Python|
|Log parsing|Regex + velocidad|

---

## Punto de partida: el contexto histórico

Perl tuvo su **pico de popularidad en los 90s y 2000s**. Hoy está en declive relativo frente a Python, Ruby, Go.

Pero "declive relativo" no significa "muerto".

---

## Una pregunta antes de darte la lista

Pensá en las **fortalezas que ya vimos**:

- Regex integrada al lenguaje
- Manipulación de texto/archivos
- Glue language entre herramientas Unix
- CPAN con módulos para casi todo

**¿En qué contextos del mundo real creés que esas fortalezas siguen siendo relevantes hoy?**

Tomate 30 segundos antes de seguir leyendo.

---

## Los nichos donde Perl _sigue vivo_

### 1. Administración de sistemas y DevOps legacy

Hay **millones de líneas de Perl** corriendo en infraestructura de empresas grandes. Nadie las reescribe porque funcionan. Sysadmins que trabajan en esos entornos _necesitan_ leer y mantener Perl.

### 2. Bioinformática

Este es el caso más sorprendente. **BioPerl** sigue siendo usado en pipelines de análisis genómico. ¿Por qué? Porque los pipelines se escribieron en los 2000s y el costo de migrar es enorme.

### 3. Procesamiento de logs y texto masivo

Empresas de telecomunicaciones, bancos, y proveedores de internet procesan logs con Perl. La razón es simple: rendimiento aceptable + regex nativa + scripts cortos.

### 4. Web legacy — cPanel

¿Sabías que **cPanel**, el panel de control de hosting más usado del mundo, está escrito mayoritariamente en Perl? Si alguna vez usaste hosting compartido, probablemente Perl procesó algo por vos.

### 5. CPAN como fuente de módulos únicos

Hay módulos en CPAN que _no existen_ en PyPI ni en npm. Algunos dominios de nicho (finanzas, telecomunicaciones, bioinformática) tienen tooling que nunca fue portado.

---

## El concepto que une todo esto

Hay un término para esto: **"sticky technology"**. Una tecnología se vuelve sticky cuando:

1. Resuelve bien un problema específico
2. Se embebe en infraestructura crítica
3. El costo de migrar supera el beneficio

**Pregunta para vos:** ¿Conocés otro lenguaje o tecnología con esta misma característica? ¿Qué dice eso sobre cómo evolucionan los ecosistemas tecnológicos?

---
Entendido, Nahuel. Dado el contexto —reunión mañana, selección de información grupal— te doy un dump completo y referenciado.

---

# Perl — Información completa para tu exposición

## 1. Historia y contexto

- Creado por **Larry Wall** en **1987**, originalmente para procesar reportes en sistemas Unix
- Wall tenía formación en **lingüística** → influyó directamente en la filosofía del lenguaje
- El nombre es un acrónimo retroactivo: **Practical Extraction and Report Language**
- Versiones clave: Perl 4 (1991), **Perl 5 (1994)** — la que sigue en uso hoy, Perl 7 (renombrado Practical Extraction and Report Language
de Perl 5.32+, aún en discusión)
- **Perl 6** se anunció en 2000, tardó 15 años, y en 2019 se renombró **Raku** por ser esencialmente un lenguaje diferente

---

## 2. Filosofía del lenguaje

**TMTOWTDI** — _"There's More Than One Way To Do It"_

Contrasta directamente con Python (_"There should be one obvious way"_). Perl privilegia **expresividad y libertad** sobre uniformidad.

**Lema secundario:** _"Easy things should be easy, hard things should be possible"_

Perl fue diseñado para que un sysadmin pudiera escribir un script útil en 5 minutos, pero también para que un experto pueda construir sistemas complejos.

---

## 3. Paradigmas que soporta

Perl es **multiparadigma**:

| Paradigma                | Soporte                                                  |
| ------------------------ | -------------------------------------------------------- |
| Imperativo/procedimental | Nativo, base del lenguaje                                |
| Orientado a objetos      | Soportado via `bless` + referencias                      |
| Funcional                | `map`, `grep`, `sort`, closures, referencias a funciones |
| Orientado a texto        | Primera clase — regex integrada al lenguaje              |

---

## 4. Sistema de tipos y variables

### Sigils — identificadores de tipo

```
$escalar    → un valor único (número, string, referencia)
@array      → lista ordenada de escalares
%hash       → pares clave-valor
&subrutina  → referencia a función
*glob       → símbolo en la tabla de símbolos
```

### Tipado dinámico y débil

- No se declara el tipo del valor, solo el contenedor
- Conversión automática entre string y número según contexto

### Contexto escalar vs. lista — concepto central

```perl
my @arr = (1, 2, 3);
my $n   = @arr;     # contexto escalar → devuelve 3 (cantidad)
my @b   = @arr;     # contexto lista   → copia los elementos
```

El mismo dato se comporta diferente según dónde está. Esto es **polimorfismo de contexto**.

### `undef`

El valor nulo de Perl. En contexto numérico es `0`, en string es `""`. No lanza error por defecto (sí con `use warnings`).

---

## 5. Sintaxis — elementos clave

### Declaración de variables

```perl
use strict;     # obliga a declarar variables
use warnings;   # activa avisos de uso problemático

my $nombre  = "Perl";       # léxica (scope local)
our $global = "visible";    # package variable
local $var  = "temporal";   # temporal en el call stack
```

### Estructuras de control

```perl
# Condicionales
if ($x > 0) { ... }
unless ($error) { ... }     # if not

# Bucles
for my $i (0..9) { ... }
foreach my $item (@lista) { ... }
while ($cond) { ... }
until ($cond) { ... }       # while not

# Postfix (muy idiomático en Perl)
print "ok\n" if $exito;
print "$_\n" for @lista;
```

### Subrutinas

```perl
sub saludar {
    my ($nombre) = @_;      # argumentos llegan en @_
    return "Hola, $nombre";
}
```

### Referencias (punteros seguros)

```perl
my @arr   = (1,2,3);
my $ref   = \@arr;          # referencia a array
my $deref = $$ref[0];       # desreferencia → 1
```

---

## 6. Expresiones regulares — la joya de Perl

Perl no usa regex como biblioteca externa. Son **sintaxis nativa**:

```perl
$texto =~ m/patrón/;        # matching
$texto =~ s/viejo/nuevo/g;  # sustitución global
$texto =~ tr/a-z/A-Z/;      # transliteración
```

**Modificadores importantes:**

- `/i` — case insensitive
- `/g` — global (todas las ocurrencias)
- `/m` — multiline
- `/x` — permite espacios y comentarios dentro de la regex

**PCRE — Perl Compatible Regular Expressions:** el estándar de regex que usa Python (`re`), Java, JavaScript, PHP y casi todos los lenguajes modernos está basado en Perl. Esto es legado directo.

---

## 7. Manejo de memoria

- **Garbage collection por conteo de referencias**
- Cuando el contador de referencias de una variable llega a 0, se libera
- **Problema:** referencias circulares → el contador nunca llega a 0
- **Solución:** `Scalar::Util::weaken()` para referencias débiles
- No hay gestión manual de memoria (a diferencia de C)

---

## 8. OOP en Perl

No hay keyword `class` nativa (hasta Perl 5.38 que la agrega experimentalmente). La OOP se construye con:

1. **Packages** como namespaces/clases
2. **Referencias** como instancias
3. **`bless`** para asociar una referencia a un package
4. **`@ISA`** o `use parent` para herencia

```perl
# Concepto, no código completo:
package Vehiculo;
# constructor: bless asocia el hashref al package
# método: subrutina dentro del package
# herencia: @ISA = ('ClasePadre')
```

**Módulos modernos que mejoran la OOP:**

- `Moose` — OOP declarativa, inspiró `Moo` y otras
- `Moo` — versión ligera de Moose
- `Corinna` / feature `class` en Perl 5.38+

---

## 9. Manejo de errores

```perl
# Tradicional
die "Error grave\n";        # lanza excepción
warn "Advertencia\n";       # imprime y continúa
eval { código_riesgoso() }; # captura errores, como try
if ($@) { ... }             # $@ contiene el error

# Moderno
use Try::Tiny;              # módulo para try/catch legible
```

---

## 10. Módulos y CPAN

**CPAN** — Comprehensive Perl Archive Network

- Lanzado en **1995**, uno de los primeros repositorios centralizados de la historia
- Actualmente tiene **+200.000 módulos**
- Fue el modelo que inspiró npm, pip, gem, cargo

**Gestor de módulos:**

```
cpan  Modulo::Nombre
cpanm Modulo::Nombre    # cpanminus, más moderno
```

**Módulos importantes para conocer:**

|Módulo|Para qué|
|---|---|
|`DBI`|Acceso a bases de datos|
|`LWP::UserAgent`|HTTP requests|
|`Moose` / `Moo`|OOP moderna|
|`Try::Tiny`|Manejo de excepciones|
|`Scalar::Util`|Utilidades de escalares|
|`File::Find`|Traversal de directorios|

---

## 11. Versiones relevantes

|Versión|Año|Hito|
|---|---|---|
|Perl 1|1987|Primera release|
|Perl 5|1994|Reescritura completa, OOP, referencias|
|Perl 5.6|2000|Unicode básico|
|Perl 5.10|2007|`say`, `given/when`, mejoras de regex|
|Perl 5.14|2011|Unicode robusto|
|Perl 5.36|2022|Features modernas, `use v5.36`|
|Perl 5.38|2023|keyword `class` experimental|

---

## 12. Fortalezas y debilidades para defender en la exposición

### Fortalezas

- Regex nativa e influyente
- CPAN maduro y extenso
- Excelente para text processing y sysadmin
- Flexibilidad extrema (TMTOWTDI)
- Legado en bioinformática, telecomunicaciones, hosting

### Debilidades

- Legibilidad comprometida por la flexibilidad
- OOP no nativa (hasta versiones recientes)
- Declive de adopción frente a Python
- `use strict` y `use warnings` son opt-in, no default
- Contexto implícito puede ser fuente de bugs difíciles

---

# Fuentes para verificar y profundizar

### Oficiales

- **perldoc.perl.org** — documentación oficial completa, gratuita, online
- **perl.org** — sitio oficial, releases, noticias
- **metacpan.org** — buscador de módulos CPAN con documentación

### Libros de referencia

- _Learning Perl_ (O'Reilly) — "El libro del camello", considerado el texto canónico de introducción
- _Programming Perl_ (O'Reilly) — escrito por Larry Wall, referencia avanzada
- _Modern Perl_ — disponible **gratis online** en `modernperlbooks.com`, cubre Perl contemporáneo

### Interactivo / práctica

- **perlmonks.org** — comunidad histórica, foros con miles de preguntas resueltas
- **learn.perl.org** — tutoriales oficiales para principiantes
- **Perl Weekly** (`perlweekly.com`) — newsletter con estado actual del ecosistema

### Para entender el contexto histórico

- _Historia de CPAN_ en el blog de metacpan
- Wikipedia: artículo "Perl" tiene referencias académicas y timeline verificable

---

Eso es todo lo que necesitás para la reunión de mañana. Si durante la reunión surge alguna duda específica o necesitan profundizar algún punto para la exposición, sabés dónde encontrarme.


---

## Sigils

Para entender los _sigils_ en Perl, la clave no es solo ver qué guardan, sino cómo estructuran la memoria y el acceso a los datos. En Perl, el _sigil_ describe el tipo de **expresión**, no necesariamente el tipo de la variable en su declaración.

Aquí tienes un ejemplo directo y conciso de cada uno, modelado de forma limpia:

### 1. `$` (Escalar)

Contiene un único elemento de datos. Puede ser un número, una cadena de texto o una referencia (un puntero a otra estructura).

Perl

```
my $edad   = 24;
my $nombre = "Alan Turing";
my $ref_a_array = [1, 2, 3]; # Referencia (un único valor que apunta a una lista)
```

### 2. `@` (Array)

Representa una lista ordenada de escalares indexada por enteros (comenzando en 0).

Perl

```
my @lenguajes = ("Perl", "C", "Lisp");

# Para acceder a un elemento, cambias el sigil a $ porque el resultado es un escalar:
print $lenguajes[0]; # Imprime: Perl
```

### 3. `%` (Hash)

Una estructura de datos asociativa (diccionario). Mapea claves únicas (strings) a valores (escalares).

Perl

```
my %capitales = (
    "Argentina" => "Buenos Aires",
    "Francia"   => "París",
);

# Al acceder a un valor por su clave, el resultado es un escalar ($):
print $capitales{"Argentina"}; # Imprime: Buenos Aires
```

### 4. `&` (Subrutina)

Identifica una función. En Perl moderno, el sigil `&` se omite casi siempre al _llamar_ a la función, pero es **obligatorio** cuando quieres obtener una referencia a la función o manipularla como un objeto de primera clase.

Perl

```
sub saludar {
    print "Hola, Mundo\n";
}

# Uso moderno (llamada directa)
saludar(); 

# Uso del sigil para crear una referencia a la subrutina
my $ref_funcion = \&saludar; 
$ref_funcion->(); # Ejecuta la función a través de la referencia
```

### 5. `*` (Typeglob)

Este es el mecanismo interno de Perl para gestionar la **tabla de símbolos** (package symbol table). Un `typeglob` representa a _todos_ los tipos de variables que comparten el mismo nombre en el paquete actual (`$x`, `@x`, `%x`, `&x`, etc.).

Perl

```
our $foo = "Escalar Foo";
our @foo = ("Elemento Array 1", "Elemento Array 2");

# Asignamos el typeglob *foo a *bar
our *bar = *foo;

# Ahora, $bar y @bar son alias exactos de $foo y @foo en la tabla de símbolos
print $bar;    # Imprime: Escalar Foo
print $bar[0]; # Imprime: Elemento Array 1
```

> **Nota técnica:** Históricamente, `*glob` se usaba para pasar _filehandles_ (manejadores de archivos) a subrutinas antes de que existieran las referencias léxicas. Hoy se usa principalmente para metaprogramación, aliasing de funciones y manipulación de la tabla de símbolos en tiempo de ejecución.

¿Hay alguna ambición específica en tu código donde planees usar `typeglobs` o referencias a subrutinas, o estás analizando la estructura del compilador de Perl?


---


