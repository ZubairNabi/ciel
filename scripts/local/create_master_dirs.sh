#!/bin/bash
#SCRIPT:  create_master_dirs.sh
#PURPOSE: Create directory structure for master

FILENAME=$1
USERNAME=root

ROOT_DIR=/mnt/ssd

while read MACHINE
do
      CIEL_DIR=$ROOT_DIR/$MACHINE/ciel_data
      LOG_DIR=$CIEL_DIR/logs
      PID_DIR=$CIEL_DIR/pid
      BS_DIR=$CIEL_DIR/block_store
      JJ_DIR=$CIEL_DIR/job_journal
      JOB_LOGS_DIR=$CIEL_DIR/jobs
      TEMP_DIR=$CIEL_DIR/tmp
      echo "Creating folder structure for master on container $MACHINE"
      mkdir $CIEL_DIR; mkdir $LOG_DIR; mkdir $PID_DIR; mkdir $BS_DIR; mkdir $JJ_DIR; mkdir $JOB_LOGS_DIR; mkdir $TEMP_DIR

done < $FILENAME
