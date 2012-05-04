#!/bin/bash
#SCRIPT:  delete_block_store_results.sh
#PURPOSE: Delete job results on each worker

FILENAME=$1
USERNAME=root

CIEL_DIR=/root/ciel_data
BS_DIR=$CIEL_DIR/block_store
BS_DATA_DIR=$BS_DIR/data

while read MACHINE
do
      echo "Deleting results in block store on container $MACHINE"
      ssh -n $MACHINE "cd $BS_DATA_DIR; ls -a | grep -v upload | xargs rm"

done < $FILENAME
