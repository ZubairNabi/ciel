#!/bin/bash
#SCRIPT:  replace_interface.sh
#PURPOSE: Replace network interfacs file for containers

FILENAME=$1
CONFIG=$2

while read MACHINE
do
      echo "Replacing config for $MACHINE"
      cp /mnt/vfs$MACHINE/root/$CONFIG /mnt/vfs$MACHINE/etc/network/interfaces

done < $FILENAME
