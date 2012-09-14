#!/bin/bash
#SCRIPT:  stop_ciel.sh
#PURPOSE: Stop ciel worker on each machine

FILENAME_MASTER=$1
FILENAME_WORKERS=$2
USERNAME=ubuntu

while read MASTER
do
      echo "Stopping CIEL master on $MASTER"
      ssh -n $USERNAME@$MASTER '/state/partition1/ciel/scripts/stop_ciel_master.sh'

done < $FILENAME_MASTER

while read MACHINE
do
      echo "Stopping CIEL worker on $MACHINE"
      ssh -n $USERNAME@$MACHINE '/state/partition1/ciel/scripts/stop_ciel_worker.sh'

done < $FILENAME_WORKERS

