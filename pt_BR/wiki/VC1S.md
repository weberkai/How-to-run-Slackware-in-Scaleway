# VC1S

A virtual X86-64 server  
2 x86 64bit Cores  
2GB Memory  
50GB SSD Disk

1 Flexible public IPv4  
200Mbit/s Unmetered bandwidth

## Configuração

Criar um /etc/resolv.conf vazio  
Configurar ttyS0 como vt220 a 9600 bauds no /etc/inittab e /etc/securetty  
Configurar / como /dev/vda no /etc/fstab  
Em /etc/rc.inet1.conf deixar eth0 vazio pois já foi configurado durante o boot  
Em rc.local chamar os scripts da scaleway
