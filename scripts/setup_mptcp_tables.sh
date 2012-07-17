#!/bin/bash
#SCRIPT:  setup_mptcp_tables.sh
#PURPOSE: Setup MPTCP routing tables on all machiens

INTF1=$1
INTF2=$2
ip rule add from 192.168.1.$INTF1 table 1
ip rule add from 192.168.2.$INTF2 table 2
ip route add 192.168.1.0/24 dev eth0 scope link table 1
ip route add default via 192.168.1.1 dev eth0 table 1
ip route add 192.168.2.0/24 dev eth1 scope link table 2
ip route add default via 192.168.2.1 dev eth1 table 2
ip route add default scope global nexthop via 192.168.1.1 dev eth0
ip route del default scope global nexthop via 192.168.2.1 dev eth1
