#!/bin/bash
#SCRIPT:  setup_network_native.sh
#PURPOSE: Sets up the Linux bridge based network for all containers

echo brctl delbr br0
brctl delbr br0

echo brctl addbr br0
brctl addbr br0

echo brctl addif br0 dummy0
brctl addif br0 dummy0

echo ifconfig dummy0 0.0.0.0
ifconfig dummy0 0.0.0.0

echo ifconfig br0 192.168.1.1 netmask 255.255.255.0 up
ifconfig br0 192.168.1.1 netmask 255.255.255.0 up

echo iptables --table filter --insert INPUT --source 192.168.1.0/255.255.255.0 --jump ACCEPT
iptables --table filter --insert INPUT --source 192.168.1.0/255.255.255.0 --jump ACCEPT

echo iptables --table filter --insert FORWARD --source 192.168.1.0/255.255.255.0 --jump ACCEPT
iptables --table filter --insert FORWARD --source 192.168.1.0/255.255.255.0 --jump ACCEPT

echo iptables --table filter --insert FORWARD --destination 192.168.1.0/255.255.255.0 --match state --state ESTABLISHED,RELATED --jump ACCEPT
iptables --table filter --insert FORWARD --destination 192.168.1.0/255.255.255.0 --match state --state ESTABLISHED,RELATED --jump ACCEPT

echo iptables --table nat --insert POSTROUTING --source 192.168.1.0/255.255.255.0 ! --destination 192.168.1.0/255.255.255.0 --jump MASQUERADE
iptables --table nat --insert POSTROUTING --source 192.168.1.0/255.255.255.0 ! --destination 192.168.1.0/255.255.255.0 --jump MASQUERADE

echo "echo 256 > /proc/sys/net/ipv4/neigh/default/gc_thresh1"
echo 256 > /proc/sys/net/ipv4/neigh/default/gc_thresh1

echo "echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh2"
echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh2

echo "echo 2048 > /proc/sys/net/ipv4/neigh/default/gc_thresh3"
echo 2048 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
