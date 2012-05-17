#!/bin/bash
#SCRIPT:  tail_worker_logs_local.sh
#PURPOSE: Tail the log of each local worker

FILENAME=$1
USERNAME=root

ROOT_DIR=/mnt/ssd/ssd

while read MACHINE
do
      CIEL_DIR=$ROOT_DIR/$MACHINE/ciel_data
      LOG_DIR=$CIEL_DIR/logs
      echo "Tailing log of $MACHINE"
      tail "$LOG_DIR/$MACHINE.log"

done < $FILENAME
