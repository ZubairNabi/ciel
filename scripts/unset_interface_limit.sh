#!/bin/bash
#SCRIPT:  unset_interface_limit.sh
#PURPOSE: Unset interface limit

FILENAME=$1

while read MACHINE
do
      echo "Setting rate 0 and burst 0 for veth_$MACHINE"
      ovs-vsctl set Interface veth_$MACHINE ingress_policing_rate=0
      ovs-vsctl set Interface veth_$MACHINE ingress_policing_burst=0

done < $FILENAME
