#!/usr/bin/perl

package SomeExamples;

use stricts;
use warnings;

my $linea = "100 usuarios activos\n";
my $factor = 2;

# Contexto Numérico: El operador '*' fuerza a Perl a extraer el número del inicio del string.
my $total = $linea * $factor; 
print "Total: $total\n"; # Imprime: 200

# Contexto de String: El operador '.' fuerza la concatenación.
my $mensaje = $total . " procesados.";
print $mensaje . "\n"; # Imprime: 200 procesados.

# Copias de valores escalares
my $a = 10;
my $b = $a;
$a = 99;
print "Valor de A: ".$a. "\n";
print "Valor de B: ".$b. "\n";

# Copia de valores de arreglos
my @arr  = (1,2,3);
my @arr2 = @arr;
print "@arr2"."\n";

print "@arr2"."\n";
print "-----------------------\n";
@arr2[0] = 5;
print "@arr2"."\n";
print "-----------------------\n";
#Modificamos verificamos que @arr no fue modificado.
foreach my $elem (@arr) {$elem = $elem * 2;}
print "@arr"."\n";

## Mutabilidad
# Constantes
#
use constant PI => 3.14159; # Sugar sintáctico
# internamente es: sub PI { 3.14159 }
# PI()  →  3.14159
#

## Pasaje de params
sub suma {
    my ($a, $b) = @_;    # vos los extraés manualmente
    return $a + $b;
}
print "Suma(1,2,3,4): " . suma(1, 2, 3, 4) . "\n";        # válido — los extra se ignoran
print "Suma(1):       " . suma(1)          . "\n";        # válido — $b queda undef


## Pasaje de params
sub suma2 {
    my ($a, $b) = @_;    # vos los extraés manualmente
    my $c = 0;
    if (@_ % 2 == 0) { $c += @_ ;}
    return $c;
}
print "Suma(1,2,3,4): " . suma2(1, 2, 3, 4) . "\n";        # válido — los extra se ignoran
print "Suma(1):       " . suma2(1)          . "\n";                 # válido — $b queda undef




my @numeros = (3,2,1);
my @ordenados = sort { $a >= $b } @numeros;
# (1,2,3)
print "@ordenados"."\n";


sub aplicar {
    my ($f, @lista) = @_;
    return map { $f->($_) } @lista;
}

sub f1 {
  my $v = @_;
  return $v * 3;
}

my @result = aplicar(\&f1, 1, 2, 3);
print "@result";
