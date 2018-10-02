#!/bin/sh

# Default Policy
iptables --flush

iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP

# Allow DNS 

DNS_SERVER="1.1.1.1 1.0.0.1"

for ip in $DNS_SERVER
do
	iptables -A OUTPUT -p udp -d $ip --dport 53 -j ACCEPT
	iptables -A INPUT  -p udp -s $ip --sport 53 -j ACCEPT
	iptables -A OUTPUT -p tcp -d $ip --dport 53 -j ACCEPT
	iptables -A INPUT  -p tcp -s $ip --sport 53 -j ACCEPT

	iptables -A FORWARD -i enp0s8 -o enp0s3 -p tcp -d $ip --dport 53 -j ACCEPT
	iptables -A FORWARD -i enp0s8 -o enp0s3 -p udp -d $ip --dport 53 -j ACCEPT

	iptables -A FORWARD -i enp0s3 -o enp0s8 -p tcp -s $ip --sport 53 -j ACCEPT
	iptables -A FORWARD -i enp0s3 -o enp0s8 -p udp -s $ip --sport 53 -j ACCEPT
done

# Allow Internet Access
iptables -A OUTPUT -p tcp -o enp0s3 --dport 80  -j ACCEPT
iptables -A OUTPUT -p tcp -o enp0s3 --dport 443  -j ACCEPT

iptables -A INPUT -i enp0s3 -p tcp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p icmp -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A FORWARD -p icmp -j ACCEPT

## Forward Established Packets
iptables -A FORWARD -m state --state ESTABLISHED -j ACCEPT
iptables -A FORWARD -i enp0s8 -o enp0s3 -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -o enp0s3 -i enp0s8 -p tcp --sport 80 -j ACCEPT
iptables -A FORWARD -i enp0s8 -o enp0s3 -p tcp --dport 443 -j ACCEPT
iptables -A FORWARD -o enp0s3 -i enp0s8 -p tcp --sport 443 -j ACCEPT

# Allow Port 22 For SSH
iptables -A INPUT -i enp0s3 -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --sport 22 -j ACCEPT

# Allow Port 9418 for Git
iptables -A OUTPUT -o enp0s3 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# Masquerade IP Address
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE

# Port Forward 80
## Allow
iptables -A INPUT -i enp0s3 -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --sport 80 -j ACCEPT

iptables -A INPUT -i enp0s8 -p tcp --sport 80 -s 192.168.1.80 -j ACCEPT
iptables -A OUTPUT -o enp0s8 -p tcp --dport 80 -d 192.168.1.80 -j ACCEPT
iptables -A FORWARD -i enp0s8 -p tcp --sport 80 -s 192.168.1.80 -j ACCEPT

## Port Forward
iptables -A PREROUTING -t nat -i enp0s3 -p tcp --dport 80 -j DNAT --to 192.168.1.80:80
iptables -A FORWARD -i enp0s3 -o enp0s8 -p tcp -d 192.168.1.80 --dport 80 -j ACCEPT
