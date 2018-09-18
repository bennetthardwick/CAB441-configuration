#!/bin/sh

iptables -t nat -A PREROUTING -i enp0s9 -p tcp --dport 80 -j DNAT --to 10.10.1.254:80
