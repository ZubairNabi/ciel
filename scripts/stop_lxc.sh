#!/bin/bash
#SCRIPT:  stop_lxc.sh
#PURPOSE: Stop all containers

FILENAME=$1
USERNAME=root

while read MACHINE
do
      echo "Stopping container $MACHINE"
      lxc-stop -n $MACHINE
      sleep 1

done < $FILENAME
