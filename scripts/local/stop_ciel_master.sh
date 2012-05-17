#!/bin/bash
#SCRIPT:  stop_ciel_master.sh
#PURPOSE: Stop ciel master on machine

HOST_NAME=`cat /etc/hostname`
ROOT_DIR=/mnt
CIEL_DIR=$ROOT_DIR/$HOST_NAME/ciel_data
PID_DIR=$CIEL_DIR/pid
PID=`cat $PID_DIR/$HOST_NAME`

echo "Killing master with pid $PID on $HOST_NAME"
kill $PID
