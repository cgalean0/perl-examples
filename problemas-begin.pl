# Algunos problemitas en la etapa de 
# compilacion de un programa perl.
#

package BeginProblems;
use strict;
use warnings;

# ===============================================

# Este fragmento de código lanza una advertencia
# en lugar de imprimir 42 cuando termine, imprime
# Global symbol "$x" requires explicit package name at script.pl line 18.
# print "Valor de X: $x\n";    # línea 14
#
# BEGIN {
#     $x = 42;                  # línea 16
# }
# El archivo se lee en cascada.
# 1. El parser encuentra BEGIN en línea 16
# 2. Ejecuta BEGIN INMEDIATAMENTE — $x = 42
# 3. Continúa parseando el resto
# 4. Al llegar a línea 14, bajo use strict, $x no fue declarada con my
# 5. Error de compilación — el programa nunca llega a ejecutarse

# ===============================================

# ===============================================
# Pasamos a otro ejemplo del problema con BEGIN.
# El orden de ejecución se ve mejor con este ejmp
# ===============================================

BEGIN {
    print "Esto corre PRIMERO\n";}

print "Esto corre SEGUNDO\n";

BEGIN {
    print "Esto corre ANTES que línea 39\n";
}

