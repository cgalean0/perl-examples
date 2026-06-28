# =============================
# Ejemplo en el uso de threads
# en Perl.
# =============================

package ThreadsExamples;
use strict;
use warnings;
use threads;
use threads::shared;

my $shr : shared = 0; # Indicamos que es una variable
                      # que compartiran ambos threads.

my $t1 = threads->create(sub {
    print "Llamando al thread 1...\n";
    sleep(2);
    print "Iniciando el contador de la variable shared\n";
    sleep(2);
    lock($shr);
    for my $i (1..10) {
      $shr++;
    }
});

my $t2 = threads->create(sub {
    print "Llamando al thread 2...\n";
    sleep(2);
    print "Iniciando el contador de la variable shared\n";
    sleep(2);
    lock($shr);
    for my $i (1..10) {
      $shr++;
    }
});

$t1->join();      # bloquea hasta que el thread termine
$t2->join();
print $shr;       # imprime 20
