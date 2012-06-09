#!/bin/bash
#SCRIPT:  unbond_interface.sh
#PURPOSE: Unbond interface on all containers

FILENAME=$1
INTERFACE=$2
USERNAME=root
COUNT=1

while read MACHINE
do
      echo "Unbonding $INTERFACE from bond$COUNT on $MACHINE"
      ssh -n $MACHINE ifenslave -d bond$COUNT $INTERFACE
      COUNT=`expr $COUNT + 1` 

done < $FILENAME
