#!/bin/bash
#SCRIPT:  refresh_worker_logs.sh
#PURPOSE: Refresh the log on all workers

FILENAME=$1

CIEL_DIR=/mnt/ciel_data
#CIEL_DIR=/root/ciel_data
LOG_DIR=$CIEL_DIR/logs

while read MACHINE
do
      echo "Refreshing log of $MACHINE"
      ssh -n $MACHINE "cat /dev/null > $LOG_DIR/$MACHINE.log"

done < $FILENAME
