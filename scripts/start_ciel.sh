#!/bin/bash
#SCRIPT:  start_ciel.sh
#PURPOSE: Start ciel worker on each machine and start master

FILENAME_MASTER=$1
FILENAME_WORKERS=$2
USERNAME=ubuntu
MASTER_IP=''

while read MASTER
do
      MASTER_IP=$MASTER
      echo "Starting CIEL master on $MASTER"
      ssh -n $USERNAME@$MASTER '/state/partition1/ciel/scripts/start_ciel_master.sh'

done < $FILENAME_MASTER

while read MACHINE
do
      echo "Starting CIEL worker on $MACHINE"
      ssh -n $USERNAME@$MACHINE "/state/partition1/ciel/scripts/start_ciel_worker.sh $MASTER_IP $MACHINE"

done < $FILENAME_WORKERS
