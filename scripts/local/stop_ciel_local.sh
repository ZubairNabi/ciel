#!/bin/bash
#SCRIPT:  stop_ciel_local.sh
#PURPOSE: Stop ciel locally

FILENAME_MASTER=$1
FILENAME_WORKERS=$2
USERNAME=root

MOUNT_DIR=/mnt/vfs
CIEL_DIR=/root/ciel_data
PID_DIR=$CIEL_DIR/pid

while read MASTER
do
      echo $PID
      PID=`cat $MOUNT_DIR$MASTER$PID_DIR/$MASTER`
      echo "Stopping CIEL master on $MASTER"
      kill $PID
      sleep 1

done < $FILENAME_MASTER

while read MACHINE
do
      PID=`cat $MOUNT_DIR$MACHINE$PID_DIR/$MACHINE`
      echo "Stopping CIEL worker on $MACHINE"
      kill $PID
      sleep 1

done < $FILENAME_WORKERS

