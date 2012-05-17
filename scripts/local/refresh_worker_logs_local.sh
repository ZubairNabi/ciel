#!/bin/bash
#SCRIPT:  refresh_worker_logs_local.sh
#PURPOSE: Refresh the log on all local workers

FILENAME=$1

ROOT_DIR=/mnt/ssd

while read MACHINE
do
      CIEL_DIR=$ROOT_DIR/$MACHINE/ciel_data
      LOG_DIR=$CIEL_DIR/logs
      echo "Refreshing log of $MACHINE"
      cat /dev/null > "$LOG_DIR/$MACHINE.log"

done < $FILENAME
