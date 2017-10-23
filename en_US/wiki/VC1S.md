# VC1S

A virtual X86-64 server  
2 x86 64bit Cores  
2GB Memory  
50GB SSD Disk

1 Flexible public IPv4  
200Mbit/s Unmetered bandwidth

## Setup

Create an empty /etc/resolv.conf  
Set ttyS0 as vt220 at 9600 bauds in /etc/inittab and /etc/securetty  
Configurar / como /dev/vda no /etc/fstab  
In /etc/rc.inet1.conf let eth0 empty because it was already set during boot  
In rc.local call scaleway boot scripts
