#!/bin/bash
#SCRIPT:  ping_machines.sh
#PURPOSE: Ping all machines

FILENAME=$1
USERNAME=root

while read MACHINE
do
      echo "Ping machine $MACHINE"
      ping -c1 $MACHINE 

done < $FILENAME
