#!/bin/bash
#SCRIPT:  mount_volumes.sh
#PURPOSE: Mount logical volumes

FILENAME=$1

while read MACHINE
do
      echo "Mounting $MACHINE"
      mount -t ext3 /dev/tigger-0/lv$MACHINE /mnt/vfs$MACHINE
      sleep 1

done < $FILENAME
