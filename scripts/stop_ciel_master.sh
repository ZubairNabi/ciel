#!/bin/bash
#SCRIPT:  stop_ciel_master.sh
#PURPOSE: Stop ciel master on machine

#CIEL_DIR=/mnt/ciel_data
CIEL_DIR=/state/partition1/ciel_data
PID_DIR=$CIEL_DIR/pid

HOST_NAME=`cat /etc/hostname`

PID=`cat $PID_DIR/$HOST_NAME`

echo "Killing master with pid $PID on $HOST_NAME"
kill $PID
