#!/bin/bash
#SCRIPT:  setup_network_3bridges.sh
#PURPOSE: Sets up the network for containers using 3 bridges


echo rmmod bridge
rmmod bridge

echo ~/zubair/ovs_dctcp/openvswitch-1.4.0/datapath/linux/openvswitch_mod.ko
insmod ~/zubair/ovs_dctcp/openvswitch-1.4.0/datapath/linux/openvswitch_mod.ko

echo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,manager_options --pidfile --detach
ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,manager_options --pidfile --detach

echo ovs-vsctl --no-wait init
ovs-vsctl --no-wait init

echo ovs-vswitchd --pidfile --detach
ovs-vswitchd --pidfile --detach

echo insmod ~/zubair/ovs_dctcp/openvswitch-1.4.0/datapath/linux/brcompat_mod.ko
insmod ~/zubair/ovs_dctcp/openvswitch-1.4.0/datapath/linux/brcompat_mod.ko

echo ovs-brcompatd --pidfile --detach
ovs-brcompatd --pidfile --detach

echo brctl delbr br0
brctl delbr br0

echo brctl delbr br1
brctl delbr br1

echo brctl delbr br2
brctl delbr br2

echo brctl addbr br0
brctl addbr br0

echo brctl addbr br1
brctl addbr br1

echo brctl addbr br2
brctl addbr br2

echo brctl addif br0 dummy0
brctl addif br0 dummy0

echo brctl addif br1 dummy1
brctl addif br1 dummy1

echo brctl addif br2 dummy2
brctl addif br2 dummy2

echo ifconfig dummy0 0.0.0.0
ifconfig dummy0 0.0.0.0

echo ifconfig dummy1 0.0.0.0
ifconfig dummy1 0.0.0.0

echo ifconfig dummy2 0.0.0.0
ifconfig dummy2 0.0.0.0

echo ifconfig br0 192.168.1.1 netmask 255.255.255.0 up
ifconfig br0 192.168.1.1 netmask 255.255.255.0 up

echo ifconfig br1 192.168.2.1 netmask 255.255.255.0 up
ifconfig br1 192.168.2.1 netmask 255.255.255.0 up

echo ifconfig br2 192.168.3.1 netmask 255.255.255.0 up
ifconfig br2 192.168.3.1 netmask 255.255.255.0 up
