#!/bin/bash
#SCRIPT:  setup_network_mptcp.sh
#PURPOSE: Sets up the OVS based network for all containers


echo rmmod bridge
rmmod bridge

echo ~/zubair/openvswitch-1.4.0/datapath/linux/openvswitch_mod.ko
insmod ~/zubair/ovs_mptcp/openvswitch-1.4.0/datapath/linux/openvswitch_mod.ko

echo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,manager_options --pidfile --detach
ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,manager_options --pidfile --detach

echo ovs-vsctl --no-wait init
ovs-vsctl --no-wait init

echo ovs-vswitchd --pidfile --detach
ovs-vswitchd --pidfile --detach

echo insmod ~/zubair/ovs_mptcp/openvswitch-1.4.0/datapath/linux/brcompat_mod.ko
insmod ~/zubair/ovs_mptcp/openvswitch-1.4.0/datapath/linux/brcompat_mod.ko

echo ovs-brcompatd --pidfile --detach
ovs-brcompatd --pidfile --detach

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

echo "echo 512 > /proc/sys/net/ipv4/neigh/default/gc_thresh1"
echo 512 > /proc/sys/net/ipv4/neigh/default/gc_thresh1

echo "echo 2048 > /proc/sys/net/ipv4/neigh/default/gc_thresh2"
echo 2048 > /proc/sys/net/ipv4/neigh/default/gc_thresh2

echo "echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh3"
echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
