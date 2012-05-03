#!/bin/bash
#SCRIPT:  stop_ciel.sh
#PURPOSE: Stop ciel worker on each machine

FILENAME_MASTER=$1
FILENAME_WORKERS=$2
USERNAME=root

while read MASTER
do
      echo "Stopping CIEL master on $MASTER"
      ssh -n $USERNAME@$MASTER './scripts/stop_ciel_master.sh'

done < $FILENAME_MASTER

while read MACHINE
do
      echo "Stopping CIEL worker on $MACHINE"
      ssh -n $USERNAME@$MACHINE './scripts/stop_ciel_worker.sh'

done < $FILENAME_WORKERS

