#!/bin/sh
apt-get install pptpd -y
echo "localip 192.168.123.1" >> /etc/pptpd.conf
echo "remoteip 192.168.123.234-238,192.168.123.245" >> /etc/pptpd.conf

echo "armourUser1 pptpd sdfuhsudhfsliudflusdfkslhdflsudflbku *" >> /etc/ppp/chap-secrets
/etc/init.d/pptpd restart
echo "ms-dns 208.67.222.222" >> /etc/ppp/pptpd-options
echo "ms-dns 208.67.220.220" >> /etc/ppp/pptpd-options
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
sed -n '$!p' /etc/rc.local > /tmp/rc.local.temp
cp /tmp/rc.local.temp /etc/rc.local
rm /tmp/rc.local.temp
echo "/sbin/iptables -t nat -A POSTROUTING -s 192.168.123.0/24 -o eth0 -j MASQUERADE" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
