package A;
sub saludo { return "Hola desde A" }

package B;
our @ISA = ('A');
use mro 'c3'; # Forzar algoritmo C3 en este package
sub saludo { return "Hola desde B" }

package C;
our @ISA = ('A');
use mro 'c3';
# C no implementa 'saludo', lo hereda de A

package D;
our @ISA = ('B' ,'C');
use mro 'c3';

package main;
use feature 'say';
my $obj = bless {}, 'D';
say $obj->saludo();
