#!/bin/bash
#SCRIPT:  delete_dirs.sh
#PURPOSE: Delete CIEL directories on each host

FILENAME=$1
USERNAME=root

#CIEL_DIR=/mnt/ciel_data
CIEL_DIR=/root/ciel_data

while read MACHINE
do
      echo "Deleting directories on container $MACHINE"
      ssh -n $MACHINE "rm -Rf $CIEL_DIR"

done < $FILENAME
