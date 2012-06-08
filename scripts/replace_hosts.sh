#!/bin/bash
#SCRIPT:  replace_hosts.sh
#PURPOSE: Replace hosts file for containers

FILENAME=$1
CONFIG=$2

while read MACHINE
do
      echo "Replacing hosts for $MACHINE"
      cp /mnt/vfs$MACHINE/root/$CONFIG /mnt/vfs$MACHINE/etc/hosts

done < $FILENAME
