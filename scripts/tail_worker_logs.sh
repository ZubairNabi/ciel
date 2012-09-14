#!/bin/bash
#SCRIPT:  tail_worker_logs.sh
#PURPOSE: Tail the log of each worker

FILENAME=$1
USERNAME=root

CIEL_DIR=/state/partition1/ciel_data
#CIEL_DIR=/mnt/ciel_data
LOG_DIR=$CIEL_DIR/logs

while read MACHINE
do
      echo "Tailing log of $MACHINE"
      ssh -n $MACHINE tail $LOG_DIR/ip-$MACHINE.log

done < $FILENAME
