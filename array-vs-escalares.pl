# ====================================
# Arrays vs Escalares
# ====================================

package ArraysVsScalars;

use strict;
use warnings;

# Siempre DEPENDE del contexto en que estamos.
my @arr  = (1,2,3);
my $size = @arr;  # alamacena la cantidad de elementos de arr.
print "El size es => " . $size . "\n";

my $ref  = \@arr; # almacena la referencia al arreglo.
print "Referencia a arr => " . $ref . "\n";

my @arrcpy = @arr; # Genera una copia exacta del arr.
print "arr => @arr \n";
print "arrcpy => @arrcpy \n";

# Modificando la copia (arrcpy), no altera al original.
@arrcpy[1] = 8; # (1,8,3)
print "arr => @arr \n";
print "arrcpy modificado => @arrcpy \n";

# Modificando el mismo arreglo, desde
# una referencia.
my $arrref = \@arr;
print "arr => @arr \n";
$$arrref[1] = 8; # Desreferenciación al igual que en C.
print "arr modificado desde ref => @arr \n";

# ====================================
# Arrays especiales (Arrays anónimos) 
# ====================================

my $anarr = [1,2,3];
print "$anarr" . "\n"; #Imprime la direccion de [1,2,3]
print "$$anarr[2]" . "\n"; # 3
print "@$anarr" . "\n"; # Acceso al arr (1,2,3).
print "size of anarr => " . scalar(@$anarr) . "\n";

# ====================================
# Cuando usar uno u el otro 
# ====================================

my $arrsc  = [1,2,3];
my $arrsc2 = [4,5,6];
my @arr1   = (1,2,3);
my @arr2   = (4,5,6);

print "@arr1 @arr2 \n"; # Imprime los dos arreglos juntos
print "$arrsc $arrsc2 \n"; # Imprime la referencia a cada arreglo,
                           # Permitiendo tener mejor manejo de los mismos.


