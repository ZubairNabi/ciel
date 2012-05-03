#!/bin/bash
#SCRIPT:  start_ciel.sh
#PURPOSE: Start ciel worker on each machine and start master

FILENAME_MASTER=$1
FILENAME_WORKERS=$2
USERNAME=root

while read MASTER
do
      echo "Starting CIEL master on $MASTER"
      ssh -n $USERNAME@$MASTER './scripts/start_ciel_master.sh'

done < $FILENAME_MASTER

while read MACHINE
do
      echo "Starting CIEL worker on $MACHINE"
      ssh -n $USERNAME@$MACHINE './scripts/start_ciel_worker.sh'

done < $FILENAME_WORKERS
