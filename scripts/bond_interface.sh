#!/bin/bash
#SCRIPT:  bond_interface.sh
#PURPOSE: Bond interface on all containers

FILENAME=$1
INTERFACE=$2
USERNAME=root
COUNT=1

while read MACHINE
do
      echo "Bonding $INTERFACE with bond$COUNT on $MACHINE"
      ssh -n $MACHINE ifenslave bond$COUNT $INTERFACE
      COUNT=`expr $COUNT + 1` 

done < $FILENAME
