#!/bin/bash
#SCRIPT:  mount_ssd_volumes.sh
#PURPOSE: Mount SSD logical volumes

FILENAME=$1

while read MACHINE
do
      echo "Mounting SSDs $MACHINE"
      mount -t ext3 /dev/ciel_ssd_vg/lv_ssd_$MACHINE /mnt/ssd$MACHINE
      sleep 1

done < $FILENAME
