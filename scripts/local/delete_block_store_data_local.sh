#!/bin/bash
#SCRIPT:  delete_block_store_data_local.sh
#PURPOSE: Delete block store data on each local worker

FILENAME=$1
USERNAME=root

ROOT_DIR=/mnt/ssd/ssd

while read MACHINE
do
      CIEL_DIR=$ROOT_DIR/$MACHINE/ciel_data
      BS_DIR=$CIEL_DIR/block_store
      echo "Deleting block store data on container $MACHINE"
      rm -Rf $BS_DIR
      mkdir $BS_DIR

done < $FILENAME
