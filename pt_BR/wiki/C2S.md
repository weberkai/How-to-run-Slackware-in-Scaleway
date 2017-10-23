# C2S

Enjoy the most affordable x86 64bit BareMetal cloud server on earth.

4 Dedicated x86 64bit Cores  
8GB Memory  
50GB SSD Disk
 
1 Flexible public IPv4  
300Mbit/s Unmetered bandwidth  
2.5Gbit/s Internal bandwidth

## Configuração

Criar um /etc/resolv.conf vazio  
Configurar ttyS1 como vt220 a 9600 bauds no /etc/inittab e /etc/securetty  
Configurar / como /dev/nbd0 no /etc/fstab  
Em /etc/rc.inet1.conf deixar eth0 vazio pois já foi configurado durante o boot  
Em rc.S remontar / como ro  
Em rc.local chamar os scripts da scaleway  
Em rc.6 pular rc.inet1 stop e não matar @xnbd-client  
Em rc.6 executar o script shutdown de /run/initramfs
