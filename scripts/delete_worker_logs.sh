#!/bin/bash
#SCRIPT:  delete_worker_logs.sh
#PURPOSE: Delete the logs of workers

FILENAME=$1
USERNAME=root

while read MACHINE
do
      echo "Deleting log of $MACHINE"
      ssh -n $MACHINE rm -f ciel_logs/log_$MACHINE

done < $FILENAME
