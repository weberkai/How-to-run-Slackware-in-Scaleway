#!/bin/bash

DIRECTORY=packages

SL_PKGSFILES="
patches/PACKAGES.TXT
PACKAGES.TXT
"

#slackware64/PACKAGES.TXT
#slackware/PACKAGES.TXT

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
aaa_base-14.2-x86_64-2.txz
aaa_elflibs-14.2-x86_64-23.txz
aaa_terminfo-5.9-x86_64-1.txz
acl-2.2.52-x86_64-1.txz
attr-2.4.47-x86_64-1.txz
bash-4.3.048-x86_64-1_slack14.2.txz
bin-11.1-x86_64-1.txz
bind-9.10.5_P3-x86_64-1_slack14.2.txz
bzip2-1.0.6-x86_64-1.txz
coreutils-8.25-x86_64-2.txz
curl-7.56.1-x86_64-1_slack14.2.txz
cyrus-sasl-2.1.26-x86_64-1.txz
dbus-1.10.8-x86_64-2_slack14.2.txz
dcron-4.5-x86_64-5.txz
devs-2.3.1-noarch-25.txz
dhcpcd-6.8.2-x86_64-2.txz
dialog-1.2_20130523-x86_64-1.txz
diffutils-3.3-x86_64-1.txz
dmidecode-3.0-x86_64-1.txz
e2fsprogs-1.43.1-x86_64-1.txz
elvis-2.2_0-x86_64-2.txz
etc-14.2-x86_64-7.txz
eudev-3.1.5-x86_64-8.txz
file-5.25-x86_64-1.txz
findutils-4.4.2-x86_64-1.txz
gawk-4.1.3-x86_64-1.txz
gettext-0.19.8.1-x86_64-1.txz
glibc-2.23-x86_64-4_slack14.2.txz
glibc-i18n-2.23-x86_64-4_slack14.2.txz
glibc-solibs-2.23-x86_64-4_slack14.2.txz
glibc-zoneinfo-2017b-noarch-1_slack14.2.txz
gnupg-1.4.22-x86_64-1_slack14.2.txz
grep-2.25-x86_64-1.txz
gzip-1.8-x86_64-1.txz
hwdata-0.284-noarch-1.txz
infozip-6.0-x86_64-3.txz
iproute2-4.4.0-x86_64-1.txz
iptables-1.6.0-x86_64-2.txz
iputils-s20140519-x86_64-1.txz
json-c-0.12-x86_64-1.txz
kmod-22-x86_64-1.txz
less-481-x86_64-1.txz
libgudev-230-x86_64-1.txz
libmpc-1.0.3-x86_64-1.txz
libnl3-3.2.27-x86_64-1.txz
libpcap-1.8.1-x86_64-1_slack14.2.txz
libxml2-2.9.5-x86_64-1_slack14.2.txz
links-2.12-x86_64-2.txz
logrotate-3.8.9-x86_64-1.txz
lvm2-2.02.154-x86_64-1.txz
mpfr-3.1.4-x86_64-1.txz
nano-2.6.0-x86_64-1.txz
ncurses-5.9-x86_64-4.txz
net-tools-1.60.20120726git-x86_64-1.txz
network-scripts-14.2-noarch-1.txz
ntp-4.2.8p10-x86_64-1_slack14.2.txz
openssh-7.4p1-x86_64-1_slack14.2.txz
openssl-1.0.2k-x86_64-1_slack14.2.txz
openssl-solibs-1.0.2k-x86_64-1_slack14.2.txz
pcre-8.39-x86_64-1.txz
pkgtools-14.2-noarch-10.txz
polkit-0.113-x86_64-2.txz
procps-ng-3.3.11-x86_64-1.txz
rsync-3.1.2-x86_64-1.txz
screen-4.4.0-x86_64-2_slack14.2.txz
sed-4.2.2-x86_64-1.txz
shadow-4.2.1-x86_64-1.txz
slackpkg-2.82.1-noarch-3.txz
sysklogd-1.5.1-x86_64-2.txz
sysvinit-2.88dsf-x86_64-4.txz
sysvinit-functions-8.53-x86_64-2.txz
sysvinit-scripts-2.0-noarch-33.txz
tar-1.29-x86_64-1.txz
usbutils-008-x86_64-1.txz
util-linux-2.27.1-x86_64-1.txz
wget-1.18-x86_64-1.txz
which-2.21-x86_64-1.txz
xz-5.2.2-x86_64-1.txz
"

#http://slackmirror.cbpf.br/pub/slackware/slackware64-14.2/

SL_MIRRORS="
http://slackware.mirrors.ovh.net/ftp.slackware.com/slackware64-14.2/
https://packages.slackonly.com/pub/packages/14.2-x86_64/
http://repository.slacky.eu/slackware64-14.2/
http://slackware.osuosl.org/slackware64-14.2/
http://slackware.schoepfer.info/14.2_64/slackware64/
http://alien.slackbook.org/slackbuilds/
http://ponce.cc/slackware/slackware64-14.2/packages/
http://rlworkman.net/pkgs/14.2/
http://software.jaos.org/slackpacks/14.2-x86_64/
http://slakfinder.org/slackpkg+/
http://slackware.uk/people/alien/restricted_slackbuilds/
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
