#!/bin/bash

DIRECTORY=packages

SL_PKGSFILES="
slackware64/PACKAGES.TXT
slackware/PACKAGES.TXT
patches/PACKAGES.TXT
PACKAGES.TXT
"

SL_VERSION="
14.2
14.1
14.0
13.37
13.1
13.0
"

# Slackware minimal package list:
SL_PKGSLIST="
aaa_base-14.2-arm-1.txz
aaa_elflibs-14.2-arm-19.txz
aaa_terminfo-5.8-arm-1.txz
acl-2.2.52-arm-1.txz
attr-2.4.47-arm-1.txz
bash-4.3.048-arm-1_slack14.2.txz
bin-11.1-arm-3.txz
bind-9.10.5_P3-arm-1_slack14.2.txz
bzip2-1.0.6-arm-3.txz
coreutils-8.25-arm-2.txz
curl-7.55.0-arm-1_slack14.2.txz
cyrus-sasl-2.1.26-arm-1.txz
dbus-1.10.8-arm-2_slack14.2.txz
dcron-4.5-arm-5.txz
devs-2.3.1-arm-3.txz
dhcpcd-6.8.2-arm-2.txz
dialog-1.2_20130523-arm-2.txz
diffutils-3.3-arm-2.txz
dmidecode-3.0-arm-1.txz
e2fsprogs-1.43.1-arm-1.txz
elvis-2.2-arm-3.txz
etc-14.2-arm-8.txz
eudev-3.1.5-arm-4.txz
file-5.25-arm-1.txz
findutils-4.4.2-arm-3.txz
gawk-4.1.3-arm-1.txz
gettext-0.19.8.1-arm-1.txz
glibc-i18n-2.23-arm-6_slack14.2.txz
glibc-solibs-2.23-arm-6_slack14.2.txz
glibc-zoneinfo-2016e-arm-1_slack14.2.txz
gnupg-1.4.22-arm-1_slack14.2.txz
grep-2.25-arm-1.txz
gzip-1.8-arm-1.txz
hwdata-0.284-arm-1.txz
infozip-6.0-arm-4.txz
iproute2-4.4.0-arm-1.txz
iptables-1.6.0-arm-2.txz
iputils-s20140519-arm-1.txz
json-c-0.12-arm-1.txz
kmod-22-arm-1.txz
less-481-arm-1.txz
libgudev-230-arm-1.txz
libmpc-1.0.3-arm-1.txz
libnl3-3.2.27-arm-1.txz
libpcap-1.8.1-arm-1_slack14.2.txz
libxml2-2.9.4-arm-2.txz
links-2.12-arm-2.txz
logrotate-3.8.9-arm-1.txz
lvm2-2.02.154-arm-1.txz
mpfr-3.1.4-arm-1.txz
nano-2.8.6-arm-1_slack14.2.txz
ncurses-5.9-arm-6.txz
net-tools-2.73cef8a-arm-1.txz
network-scripts-14.2-noarch-1.txz
ntp-4.2.8p10-arm-1_slack14.2.txz
openssh-7.4p1-arm-1_slack14.2.txz
openssl-1.0.2k-arm-1_slack14.2.txz
openssl-solibs-1.0.2k-arm-1_slack14.2.txz
pcre-8.39-arm-1.txz
pkgtools-14.2-noarch-7_slack14.2.txz
polkit-0.113-arm-1.txz
procps-ng-3.3.11-arm-1.txz
rsync-3.1.2-arm-1.txz
screen-4.4.0-arm-2_slack14.2.txz
sed-4.2.2-arm-2.txz
shadow-4.2.1-arm-1.txz
slackpkg-2.82.1-noarch-3_slack14.2.txz
sysklogd-1.5.1-arm-2.txz
sysvinit-2.88dsf-arm-6.txz
sysvinit-functions-8.53-arm-2.txz
sysvinit-scripts-2.0-noarch-31.txz
tar-1.29-arm-1.txz
usbutils-008-arm-1.txz
util-linux-2.27.1-arm-1.txz
wget-1.18-arm-1.txz
which-2.21-arm-1.txz
xz-5.2.2-arm-1.txz
"

#http://slackmirror.cbpf.br/pub/slackware/slackware64-14.2/

SL_MIRRORS="
http://mirrors.vbi.vt.edu/linux/slackwarearm/slackwarearm-14.2/
"

if [ ! -e $DIRECTORY ]
then
	mkdir $DIRECTORY 2>/dev/null
fi
for MIRROR in $SL_MIRRORS
do
	RUN=0
	for PKG in $SL_PKGSLIST
	do
		if [ ! -e $DIRECTORY/$PKG ]
		then
			RUN=1
		fi
	done
	if [ "$RUN" == "1" ]
	then
		for PKGSFILE in $SL_PKGSFILES
		do
			PKGS=$(wget --no-check-certificate -qO- ${MIRROR}${PKGSFILE})
			for PKG in $SL_PKGSLIST
			do
				if [ ! -e $DIRECTORY/$PKG ]
				then
					REMOTEPATH=/
					MATCH=$(echo "$PKGS" | grep -A9 $PKG | grep -E 'PACKAGE NAME|PACKAGE LOCATION')
					MATCHQT=$(echo "$MATCH" | wc -l)
					if [ "$MATCHQT" == "2" ]
					then
						REMOTEPATH=$(echo "$MATCH" | xargs | awk '{print $6"/"$3}')
					else
						if [ "$MATCHQT" != "1" ]
						then
							for VERSION in $SL_VERSION
							do
								if [ "$REMOTEPATH" == "/" ]
								then
									MATCH2=$(echo "$MATCH" | grep -B1 $VERSION)
									MATCHQT2=$(echo "$MATCH2" | wc -l)
									if [ "$MATCHQT2" == "2" ]
									then
										REMOTEPATH=$(echo "$MATCH2" | xargs | awk '{print $6"/"$3}')
									fi
								fi
							done
						fi
					fi
					if [ "$REMOTEPATH" != "/" ]
					then
						wget --no-check-certificate -P $DIRECTORY ${MIRROR}${REMOTEPATH} 2>/dev/null
					fi
				fi
			done
		done
	fi
done
