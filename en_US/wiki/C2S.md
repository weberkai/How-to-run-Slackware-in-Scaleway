# C2S

Enjoy the most affordable x86 64bit BareMetal cloud server on earth.

4 Dedicated x86 64bit Cores  
8GB Memory  
50GB SSD Disk
 
1 Flexible public IPv4  
300Mbit/s Unmetered bandwidth  
2.5Gbit/s Internal bandwidth

## Setup

Create an empty /etc/resolv.conf  
Set ttyS1 as vt220 at 9600 bauds in /etc/inittab and /etc/securetty  
Set / as /dev/nbd0 in /etc/fstab  
In /etc/rc.inet1.conf let eth0 empty because it was already set during boot  
In rc.S remount / as ro  
In rc.local call scaleway boot scripts  
In rc.6 skip rc.inet1 stop and don't kill @xnbd-client  
In rc.6 call shutdown script in /run/initramfs
