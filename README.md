Z80 source code used to boot the MICRO-INNOVATIONS IDE board for the Celeco Adam
from a ROM cart.  The system originally booted from an EPROM attacted to the system
with a separate parallel card, or from the tape drive.
Parallel cards are rare, expensive, redundant... and tape is slow. 
Since multicarts are populer for games, it just made sense to boot the system
from a ROM cart image. 
The actual IDE driver isn't included here, I don't own the copyright for it.
For an example of driving an IDE port from the Z80, check out the LoTech IDE interface for the TRS-80.

The code is pretty simple, it just selects the appropriate ADAM memory map to copy a small piece of
code, and the driver to low RAM, then it jumps to that code, which changes
the memory map again, and it installs the driver.
The Colecovision ROM cart header is almost as long as the installer code.

You can find descriptions for the memory mapping hardware, and game cart 
header format in the ADAM & Colecovision developer docs.
FWIW, when I wrote this I didn't own an ADAM or Colecovision.
