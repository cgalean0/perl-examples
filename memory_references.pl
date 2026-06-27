# ==============================
# Ejemplos sobre referencias
# circulares y su manejo
# ==============================


package SinWeaken;

use strict;
use warnings;

my $persona = { nombre => "Josh" };
my $empresa = { nombre => "ARCH" };

## Generamos las referencias circulares.
$persona->{ trabajo  } = $empresa; # CountRef de $persona = 2
$empresa->{ empleado } = $persona; # CountRef de $empresa = 2

## Intentamos liberar las mismas.
undef $persona;
undef $empresa;

# Ambos seguirán en memoria ya que se apuntan
# mutuamente. Esto genera un memory leak.

package ConWeaken;

use strict;
use warnings;
use Scalar::Util 'weaken';

my $persona = { nombre => "Josh" };
my $empresa = { nombre => "ARCH" };

## Generamos las referencias circulares.
$persona->{ trabajo  } = $empresa; # CountRef de $persona = 2
$empresa->{ empleado } = $persona; # CountRef de $empresa = 2
weaken($empresa->{empleado}); # No incrementa el contador de $persona.
## Intentamos liberar las mismas.
undef $persona; # CountRef de $persona: 1 -> 0 -> Liberado.
                # Al momento que se libera persona se libera empresa
                # por perder la referencias.
undef $empresa; # CountRef de $empresa 2 -> 1 -> 0 -> Liberado.

