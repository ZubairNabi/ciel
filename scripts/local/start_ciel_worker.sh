#!/bin/bash
#SCRIPT:  start_ciel_worker.sh
#PURPOSE: Start ciel worker on machine

MASTER=ciel1
MASTER_PORT=8000
WORKER_PORT=8001
HOST_NAME=`cat /etc/hostname`
NUM_THREADS=1
ROOT_DIR=/mnt
CIEL_DIR=$ROOT_DIR/$HOST_NAME/ciel_data
LOG_DIR=$CIEL_DIR/logs
PID_DIR=$CIEL_DIR/pid
BS_DIR=$CIEL_DIR/block_store

ciel worker --master="http://$MASTER:$MASTER_PORT" --port=$WORKER_PORT --num-threads=$NUM_THREADS --pidfile="$PID_DIR/$HOST_NAME" --daemonise --logfile="$LOG_DIR/$HOST_NAME.log" --blockstore="$BS_DIR"
