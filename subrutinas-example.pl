# Ejemplos sobre anidamiento de subrutinas

package Subrutinas;
use strict;
use warnings;

# Ejemplito simple
# sub externa {
#   sub interna {
#     print "Hola soy interna\n";
#   }
#   interna();
# }
# externa();

# Acomplejizamos un poco más;
# sub externa {
#   my $x = shift;
#   sub interna {
#     # Aquí es donde Perl nos avisa que la variable x puede no ser capturada correctamente
#     # ya que se sub interna nombrada compila una sola vez en compile time
#     # y se carga en la tabla de símbolos del package.
#     # Perl lanza el siguiente mensaje;
#     # Variable "$x" will not stay shared at subrutinas-example.pl line 20.
#
#     print "Soy X de externa => $x\n";
#   }
#   interna();
# }
# externa(10); #10
# externa(99); #99 o 10 ?
#

# Esto lo solucionamos con subrutinas anónimas.
# forzando a crear una nueva variable x en cada
# llamada a la función externa
# haciendo que se capture correctamente.
sub externa {
  my $x = shift;
  my $interna = sub {
                    print "Soy x de externa $x\n";
                 };
  $interna->();
}
externa(10); # 10
externa(99); # 99 o 10?

