#!/bin/bash
#SCRIPT:  create_worker_dirs.sh
#PURPOSE: Create directory structure for workers

FILENAME=$1

ROOT_DIR=/mnt/ssd/ssd

while read MACHINE
do
      CIEL_DIR=$ROOT_DIR/$MACHINE/ciel_data
      LOG_DIR=$CIEL_DIR/logs
      PID_DIR=$CIEL_DIR/pid
      BS_DIR=$CIEL_DIR/block_store
      TEMP_DIR=$CIEL_DIR/tmp
      echo "Creating folder structure for worker on container $MACHINE"
      mkdir $CIEL_DIR; mkdir $LOG_DIR; mkdir $PID_DIR; mkdir $BS_DIR; mkdir $TEMP_DIR

done < $FILENAME
