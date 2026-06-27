# ===================================
# Algunos ejemplos sobre el scope
# y las variables.
# ===================================

package VarsAndScope;

use strict;
use warnings;

our $x = 10;

sub imprimir {
  print "El resultado es: $x\n";
}

sub con_my {
  my $x = 25;
  print "PRINT GLOBAL \n";
  imprimir();
}

sub con_local {
  local $x = 5;
  print "PRINT LOCAL \n";
  imprimir();
}
con_my();
con_local();
