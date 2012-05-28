#!/bin/bash
#SCRIPT:  set_interface_limit.sh
#PURPOSE: Set interface limit

FILENAME=$1
RATE=$2
BURST=$3

while read MACHINE
do
      echo "Setting rate $RATE and burst $3 for veth_$MACHINE"
      ovs-vsctl set Interface "veth_$MACHINE" ingress_policing_rate="$RATE"
      ovs-vsctl set Interface "veth_$MACHINE" ingress_policing_burst="$BURST"

done < $FILENAME
