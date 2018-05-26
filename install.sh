#! /bin/bash

suffix=''

while [ "$#" -gt 0 ]; do
  case "$1" in
    -m) mode="$2"; shift 2;;
    --mode=*) mode="${1#*=}"; shift 1;;
    --mode) echo "$1 requires an argument" >&2; exit 1;;

    -*) echo "unknown option: $1" >&2; exit 1;;
    *) handle_argument "$1"; shift 1;;
  esac
done

if [ "$mode" == 'slave' ];
then
  suffix='.slave'
  echo "Installing Bind Secondary (Slave) Server"
else
  echo "Installing Bind Primary (Master) Server"
fi


apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install bind9 bind9utils bind9-doc

echo "Installed `named -v`"

cp files/named.conf /etc/bind/named.conf
cp files/named.conf.local${suffix} /etc/bind/named.conf.local
cp files/named.conf.options /etc/bind/named.conf.options
cp files/named.conf.log /etc/bind/named.conf.log

chown bind:root /etc/bind/named.conf*

# Configuring Zones
echo "Copying Zone files ..."
mkdir /etc/bind/zones
cp files/db.example.com /etc/bind/zones/db.example.com
cp files/0.24.172.in-addr.arpa /etc/bind/zones/0.24.172.in-addr.arpa
cp files/0.168.192.in-addr.arpa /etc/bind/zones/0.168.192.in-addr.arpa

echo "Staring Bind9 Service"
service bind9 start

# Configuring Logging
echo "Setting up Bind9 logging "

chown bind:root /var/log/bind
chmod 775 /var/log/bind
cp /etc/apparmor.d/usr.sbin.named /etc/apparmor.d/usr.sbin.named.bak
sed -i 's/log\/named/log\/bind/g' /etc/apparmor.d/usr.sbin.named
systemctl restart apparmor

# Configuring Logrotator
cp files/bind.logrotate.conf /etc/logrotate.d/bind


# Restarting bind9 service
echo "Restarting Bind9 Service"
service bind9 restart