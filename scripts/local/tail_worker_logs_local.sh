#!/bin/bash
#SCRIPT:  tail_worker_logs_local.sh
#PURPOSE: Tail the log of each local worker

FILENAME=$1
USERNAME=root

MOUNT_DIR=/mnt/vfs
CIEL_DIR=/root/ciel_data
LOG_DIR=$CIEL_DIR/logs

while read MACHINE
do
      echo "Tailing log of $MACHINE"
      tail "$MOUNT_DIR$MACHINE$LOG_DIR/$MACHINE.log"

done < $FILENAME
