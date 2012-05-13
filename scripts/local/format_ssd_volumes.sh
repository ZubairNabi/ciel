#!/bin/bash
#SCRIPT:  format_ssd_volumes.sh
#PURPOSE: Format SSD logical volumes

FILENAME=$1

while read MACHINE
do
      echo "Formatting SSD $MACHINE"
      mkfs -t ext3 -m 1 -v /dev/ciel_ssd_vg/lv_ssd_$MACHINE
      sleep 1

done < $FILENAME
