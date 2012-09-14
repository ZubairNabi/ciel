#!/bin/bash
#SCRIPT:  start_ciel.sh
#PURPOSE: Start ciel worker on each machine and start master

FILENAME_MASTER=$1
FILENAME_WORKERS=$2
USERNAME=root
MASTER_IP=''

while read MASTER
do
      MASTER_IP=$MASTER
      echo "Starting CIEL master on $MASTER"
      ssh -n $USERNAME@$MASTER '/home/ubuntu/ciel_mrplus/scripts/start_ciel_master.sh'

done < $FILENAME_MASTER

while read MACHINE
do
      echo "Starting CIEL worker on $MACHINE"
      ssh -n $USERNAME@$MACHINE "/home/ubuntu/ciel_mrplus/scripts/start_ciel_worker.sh $MASTER_IP"

done < $FILENAME_WORKERS
