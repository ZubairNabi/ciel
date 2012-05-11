#!/bin/bash
#SCRIPT:  unmount_ssd_volumes.sh
#PURPOSE: Unmount SSD logical volumes

FILENAME=$1

while read MACHINE
do
      echo "Unmounting SSD $MACHINE"
      umount /mnt/ssd$MACHINE
      sleep 1

done < $FILENAME
