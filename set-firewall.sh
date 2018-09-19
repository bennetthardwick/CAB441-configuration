#!/bin/sh

# iptables -t nat -A PREROUTING -i enp0s9 -p tcp --dport 80 -j DNAT --to 10.10.1.254:80
# iptables -t nat -A POSTROUTING -o enp0s9 -j MASQUERADE

# iptables -t nat -A PREROUTING -i enp0s9 -p tcp --dport 80 -j DNAT --to 10.10.1.254:80
# iptables -t nat -A POSTROUTING -o enp0s9 -s 10.10.1.0/24 -d 10.10.1.254 -j SNAT --to 10.10.1.254
# iptables -A FORWARD -s 10.10.1.0/24 -d 10.10.1.254 -i enp0s9 -o enp0s9 -p tcp --dport 80 -j ACCEPT
