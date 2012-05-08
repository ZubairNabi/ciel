#!/bin/bash
#SCRIPT:  refresh_worker_logs_local.sh
#PURPOSE: Refresh the log on all local workers

FILENAME=$1

MOUNT_DIR=/mnt/vfs
CIEL_DIR=/root/ciel_data
LOG_DIR=$CIEL_DIR/logs

while read MACHINE
do
      echo "Refreshing log of $MACHINE"
      cat /dev/null > "$MOUNT_DIR$MACHINE$LOG_DIR/$MACHINE.log"

done < $FILENAME
