#!/bin/bash
#SCRIPT:  set_interface_mtu.sh
#PURPOSE: Set interface mtu

FILENAME=$1
MTU=$2

while read MACHINE
do
      echo "Setting MTU $MTU for veth_$MACHINE"
      ifconfig "veth_$MACHINE" mtu "$MTU"
      ssh -n $MACHINE ifconfig eth0 mtu "$MTU"

done < $FILENAME
