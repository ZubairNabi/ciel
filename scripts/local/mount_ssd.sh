#!/bin/bash
#SCRIPT:  mount_ssd.sh
#PURPOSE: Mount SSD

echo "Mounting SSDs $MACHINE"
mount -t ext3 /dev/sdc /mnt/ssd
