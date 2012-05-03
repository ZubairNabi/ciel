#!/bin/bash
#SCRIPT:  create_worker_dirs.sh
#PURPOSE: Create directory structure for workers

FILENAME=$1
USERNAME=root

CIEL_DIR=/root/ciel_data
LOG_DIR=$CIEL_DIR/logs
PID_DIR=$CIEL_DIR/pid
BS_DIR=$CIEL_DIR/block_store

while read MACHINE
do
      echo "Creating folder structure for worker on container $MACHINE"
      ssh -n $MACHINE "mkdir $CIEL_DIR; mkdir $LOG_DIR; mkdir $PID_DIR; mkdir $BS_DIR"

done < $FILENAME
