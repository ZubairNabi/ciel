#!/bin/bash
#SCRIPT:  start_lxc.sh
#PURPOSE: Start all containers

FILENAME=$1
USERNAME=root

while read MACHINE
do
      echo "Starting container $MACHINE"
      lxc-start -n $MACHINE -f /home/lxc/$MACHINE/config -d
      sleep 1

done < $FILENAME
