#!/bin/bash
#SCRIPT:  delete_block_store_data.sh
#PURPOSE: Delete block store data on each worker

FILENAME=$1
USERNAME=root

#CIEL_DIR=/mnt/ciel_data
CIEL_DIR=/state/partition1/ciel_data
BS_DIR=$CIEL_DIR/block_store
BS_DATA_DIR=$BS_DIR/data

while read MACHINE
do
      echo "Deleting block store data on container $MACHINE"
      ssh -n $MACHINE "cd $BS_DATA_DIR; rm -f i * .*;"

done < $FILENAME
