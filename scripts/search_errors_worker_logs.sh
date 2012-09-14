#!/bin/bash
#SCRIPT:  search_errors_worker_logs.sh
#PURPOSE: Search for errors in the log of each worker

FILENAME=$1
USERNAME=root

CIEL_DIR=/state/partition1/ciel_data
#CIEL_DIR=/mnt/ciel_data
LOG_DIR=$CIEL_DIR/logs

while read MACHINE
do
      echo "Tailing log of $MACHINE"
      ssh -n $MACHINE cat $LOG_DIR/$MACHINE.log | egrep 'error|Exception|failure'

done < $FILENAME
