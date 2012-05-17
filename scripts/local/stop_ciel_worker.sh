#!/bin/bash
#SCRIPT:  stop_ciel_worker.sh
#PURPOSE: Stop ciel worker on each machine

HOST_NAME=`cat /etc/hostname`
ROOT_DIR=/mnt/ssd
CIEL_DIR=$ROOT_DIR/$HOST_NAME/ciel_data
PID_DIR=$CIEL_DIR/pid
PID=`cat $PID_DIR/$HOST_NAME`

echo "Killing worker with pid $PID on $HOST_NAME"
kill $PID
