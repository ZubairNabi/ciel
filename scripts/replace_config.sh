#!/bin/bash
#SCRIPT:  replace_config.sh
#PURPOSE: Replace config file for containers

FILENAME=$1
CONFIG=$2

while read MACHINE
do
      echo "Replacing config for $MACHINE"
      cp /home/lxc/$MACHINE/$CONFIG /home/lxc/$MACHINE/config
      #cp /mnt/vfs$MACHINE/root/interfaces_two /mnt/vfs$MACHINE/etc/network/interfaces

done < $FILENAME
