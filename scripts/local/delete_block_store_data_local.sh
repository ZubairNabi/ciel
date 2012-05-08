#!/bin/bash
#SCRIPT:  delete_block_store_data_local.sh
#PURPOSE: Delete block store data on each local worker

FILENAME=$1
USERNAME=root

MOUNT_DIR=/mnt/vfs
CIEL_DIR=/root/ciel_data
BS_DIR=$CIEL_DIR/block_store
BS_DATA_DIR=$BS_DIR/data

while read MACHINE
do
      echo "Deleting block store data on container $MACHINE"
      cd "$MOUNT_DIR$MACHINE$BS_DATA_DIR"
      rm -f i * .*;  

done < $FILENAME
