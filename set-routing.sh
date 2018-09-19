#!/bin/sh

## Reset iptables config
# iptables -P INPUT ACCEPT
# iptables -P OUTPUT ACCEPT
# iptables -P FORWARD ACCEPT
# iptables -F
# 
## Allow only SSH on enp0s3
# iptables -A INPUT -i enp0s3 -p tcp --dport 22 -j ACCEPT
# iptables -A INPUT -i enp0s3 -j DROP

ip link set enp0s3 down

# Configure Static IPs
ip addr add 10.10.1.1/24 dev enp0s8
ip link set enp0s8 up

# Configure Routes
ip route delete default
ip route add default via 10.10.1.254 dev enp0s8
