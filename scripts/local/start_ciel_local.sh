#!/bin/bash
#SCRIPT:  start_ciel_local.sh
#PURPOSE: Start ciel locally

FILENAME_MASTER=$1
FILENAME_WORKERS=$2
USERNAME=root

MOUNT_DIR=/mnt/vfs
CIEL_DIR=/root/ciel_data
LOG_DIR=$CIEL_DIR/logs
PID_DIR=$CIEL_DIR/pid
BS_DIR=$CIEL_DIR/block_store
JJ_DIR=$CIEL_DIR/job_journal

MASTER_PORT=8000
WORKER_PORT=8002
NUM_THREADS=1

while read MASTER
do
      echo "Starting CIEL master on $MASTER"
      ciel master --pidfile="$MOUNT_DIR$MASTER$PID_DIR/$MASTER" --daemonise --logfile="$MOUNT_DIR$MASTER$LOG_DIR/$MASTER.log" --blockstore="$MOUNT_DIR$MASTER$BS_DIR"
      sleep 1

done < $FILENAME_MASTER

while read MACHINE
do
      echo "Starting CIEL worker on $MACHINE"
      ciel worker --master="http://localhost:$MASTER_PORT" --port="$WORKER_PORT" --num-threads="$NUM_THREADS" --pidfile="$MOUNT_DIR$MACHINE$PID_DIR/$MACHINE" --daemonise --logfile="$MOUNT_DIR$MACHINE$LOG_DIR/$MACHINE.log" --blockstore="$MOUNT_DIR$MACHINE$BS_DIR"
      let "WORKER_PORT += 1"
      sleep 1

done < $FILENAME_WORKERS
