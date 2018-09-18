#!/bin/sh

# Reset Config
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -F

# Allow only SSH on enp0s3
iptables -A INPUT -i enp0s3 -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i enp0s3 -j DROP

# Configure Static IPs

ip addr add 192.168.1.1/24 dev enp0s8
ip addr add 10.10.1.254/24 dev enp0s9

ip link set enp0s8 up
ip link set enp0s9 up

# Enable IP Forwarding
sysctl -w net.ipv4.ip_forward=1

# Configure Routes

ip route delete default
ip route add default via 192.168.1.80 dev enp0s8
ip route add 192.168.1.0/24 via 192.168.1.80

