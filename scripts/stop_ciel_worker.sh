#!/bin/bash
#SCRIPT:  stop_ciel_worker.sh
#PURPOSE: Stop ciel worker on each machine

#CIEL_DIR=/mnt/ciel_data
CIEL_DIR=/state/partition1/ciel_data
PID_DIR=$CIEL_DIR/pid

HOST_NAME=$1

PID=`cat $PID_DIR/$HOST_NAME`

echo "Killing worker with pid $PID on $HOST_NAME"
kill $PID
