#!/bin/bash
#SCRIPT:  start_ciel_worker.sh
#PURPOSE: Start ciel worker on machine

CIEL_DIR=/state/partition1/ciel_data
#CIEL_DIR=/mnt/ciel_data
LOG_DIR=$CIEL_DIR/logs
PID_DIR=$CIEL_DIR/pid
BS_DIR=$CIEL_DIR/block_store

MASTER=$1
MASTER_PORT=8000
WORKER_PORT=8001
HOST_NAME=$2
NUM_THREADS=4

ciel worker --master="http://$MASTER:$MASTER_PORT" --port=$WORKER_PORT --num-threads=$NUM_THREADS --pidfile="$PID_DIR/$HOST_NAME" --daemonise --logfile="$LOG_DIR/$HOST_NAME.log" --blockstore="$BS_DIR"
