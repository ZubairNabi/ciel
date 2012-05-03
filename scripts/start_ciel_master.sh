#!/bin/bash
#SCRIPT:  start_ciel_master.sh
#PURPOSE: Start ciel master on machine

CIEL_DIR=/root/ciel_data
LOG_DIR=$CIEL_DIR/logs
PID_DIR=$CIEL_DIR/pid

HOST_NAME=`cat /etc/hostname`

ciel master --pidfile="$PID_DIR/$HOST_NAME" --daemonise --logfile="$LOG_DIR/$HOST_NAME.log"
