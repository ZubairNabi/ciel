#!/bin/bash
#SCRIPT:  search_errors_worker_logs.sh
#PURPOSE: Search for errors in the log of each worker

FILENAME=$1
USERNAME=root

ROOT_DIR=/mnt/ssd/ssd

while read MACHINE
do
      CIEL_DIR=$ROOT_DIR/$MACHINE/ciel_data
      LOG_DIR=$CIEL_DIR/logs
      echo "Tailing log of $MACHINE for errors"
      cat $LOG_DIR/$MACHINE.log | egrep 'error|Exception|failure'

done < $FILENAME
