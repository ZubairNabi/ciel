#!/bin/bash
#SCRIPT:  unmount_volumes.sh
#PURPOSE: Unmount logical volumes

FILENAME=$1

while read MACHINE
do
      echo "Unmounting $MACHINE"
      umount /mnt/vfs$MACHINE
      sleep 1

done < $FILENAME
