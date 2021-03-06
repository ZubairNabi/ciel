#!/bin/bash
#SCRIPT:  start_ciel_master.sh
#PURPOSE: Start ciel master on machine

CIEL_DIR=/root/ciel_data
#CIEL_DIR=/mnt/ciel_data
LOG_DIR=$CIEL_DIR/logs
PID_DIR=$CIEL_DIR/pid
BS_DIR=$CIEL_DIR/block_store
JJ_DIR=$CIEL_DIR/job_journal

HOST_NAME=`cat /etc/hostname`

ciel master --pidfile="$PID_DIR/$HOST_NAME" --daemonise --logfile="$LOG_DIR/$HOST_NAME.log" --blockstore="$BS_DIR" --task-log-root="$LOG_DIR"
