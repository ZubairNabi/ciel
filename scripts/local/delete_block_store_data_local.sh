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
      BS_DATA_DIR=$BS_DIR/data
      echo "Deleting block store data on container $MACHINE"
      rm -Rf $BS_DATA_DIR
      mkdir $BS_DATA_DIR

done < $FILENAME
