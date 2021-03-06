#!/bin/bash

#list of dependencies
cat <<EOF >/dev/null # > config/package-lists/kali.list.chroot
kali-root-login
kali-defaults
kali-debtags
kali-archive-keyring
debian-installer-launcher
cryptsetup
locales-all
hostapd
dnsmasq
nginx
wireless-tools
iw
aircrack-ng
openssl
sslsplit
responder
openssh-server
openvpn
nginx
EOF

mkdir -p config/includes.chroot/etc/hostapd
mkdir -p config/includes.chroot/etc/init.d

cat <<EOF > config/includes.chroot/etc/hostapd/hostapd.conf
interface=wlan0
driver=nl80211
ssid=OpenFreeWifi
channel=1
EOF

cat <<EOF > config/includes.chroot/etc/dnsmasq.conf
log-facility=/var/log/dnsmasq.log
#address=/#/10.0.0.1
#address=/google.com/10.0.0.1
interface=wlan0
dhcp-range=10.0.0.10,10.0.0.250,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1
#no-resolv
log-queries
EOF

iptables-save > iptables.bak 
#to restore iptables: iptables-restore < iptables.back

cat <<EOF >> config/includes.chroot/etc/iptables.rules 
*nat
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -o eth0 -j MASQUERADE
COMMIT
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A FORWARD -i wlan0 -o eth0 -j ACCEPT
COMMIT
EOF


cat <<EOF > config/includes.chroot/etc/rc.local
#!/bin/bash
ifconfig wlan0 up
ifconfig wlan0 10.0.0.1/24
iptables-restore < /etc/iptables.rules
echo '1' > /proc/sys/net/ipv4/ip_forward
EOF

cat <<EOF >config/hooks/enableservices.chroot
#!/bin/bash
update-rc.d nginx enable
update-rc.d hostapd enable
update-rc.d dnsmasq enable
EOF


cat <<EOF >config/hooks/configurehostapd.chroot
#!/bin/bash
sed -i 's#^DAEMON_CONF=.*#DAEMON_CONF=/etc/hostapd/hostapd.conf#' /etc/init.d/hostapd
EOF


chmod 755 config/hooks/enableservices.chroot
chmod 755 config/hooks/configurehostapd.chroot
chmod 755 config/includes.chroot/etc/rc.local

#run build
lb build
