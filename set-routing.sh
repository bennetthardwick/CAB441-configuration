#!/bin/sh

# Reset Config
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F

# Allow Port 22 For SSH
iptables -A INPUT -i enp0s3 -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --sport 22 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i enp0s3 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT


iptables -A INPUT -i enp0s3 -j DROP

# Configure Static IPs

ip addr add 192.168.1.80/24 dev enp0s8

ip link set enp0s8 up

# Enable IP Forwarding
sysctl -w net.ipv4.ip_forward=1

# Configure Routes 
ip route delete default

ip route add default via 192.168.1.254 dev enp0s8
ip route add 10.10.1.0/24 via 192.168.1.1 dev enp0s8
