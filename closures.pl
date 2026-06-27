# Ejemplos sobre closures
#
package Closure;

use strict;
use warnings;

sub make_counter {
  my $count = 0;
  return sub { return ++$count };
} # Por mas que aquí muera make_counter
  # count aún sigue vivia ya que aún es referenciada
  # en el heap por una sub rutina anónima.

my $c = make_counter();

sub evens {
  my $curr = $c->();

  while ($curr <= 10) {
    print "$curr\n" if ($curr % 2 == 0);
    $curr = $c->();
  }
}

evens();
