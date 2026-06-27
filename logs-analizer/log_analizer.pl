# ==================================
# Programa el cual nos permite
# filtrar los distintos resultados
# de un logfile;
# ==================================


package LogAnalizer;
use strict;
use warnings;

# Hacemos la lectura del archivo el cual 
# contiene los logs.
my $file_name = "logfile.txt";
open(my $fi, '<', $file_name) or die "Cannot open file 'file name' for reading: $!";

# En este ejemplo no nos interesan las lineas
# de [ INFO ] de los logs, solo nos queremos 
# quedar con los [ WARN ], [ ERROR ] y los [ FATAL ].
# Ya que son los más importantes.
while (my $line = <$fi>) {
  if ($line =~ /\[(?:WARN|ERROR|FATAL)\]/) {
    print $line;
  }
}

close($fi);
