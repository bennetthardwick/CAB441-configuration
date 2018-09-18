#!/bin/sh

# Set Static IP
ip addr add 192.168.1.254/24 dev enp0s8
ip link set enp0s8 up

ip route add 10.10.1.0/24 via 192.168.1.80 dev enp0s8

iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
