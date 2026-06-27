# ===================================
# Ejemplos sobre los tipos
# y contexto de Perl.
# ===================================

use strict;
#use warnings;

my $line   = "100 Alumnos";
my $factor = 2;

# Para este ejemplo no debemos tener
# warnings activos.
my $total = $line * $factor;
print "El resultado es: " . $total . "\n";

my $newline = $total . " procesados";
print "$newline \n";

# ===================================
