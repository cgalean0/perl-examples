# Script que toma un archivo de fechas
# con el formato DD-MM-YYYY y lo transforma
# al formato DD/MM/YYYY.
#

package DateModule;

use strict;
use warnings;

open(my $fi, '<', "fechas.txt") or die "Cannot open file 'file name' for reading: $!";
open(my $fo, '>', "file-modified.txt") or die "Cannot open file 'file name' for writing: $!";

while (my $line = <$fi>) {
  chomp $line;
  $line =~ s/-/\//g;
  print $fo $line."\n";
}
close($fi);
close($fo);
