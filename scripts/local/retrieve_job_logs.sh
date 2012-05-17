#!/bin/bash
#SCRIPT:  retrieve_job_logs.sh
#PURPOSE: Retrieve logs for a particular job from all machines

FILENAME=$1
JOBID=$2

ROOT_DIR=/mnt/ssd/ssd
JOB_FILENAME=$JOBID.log
JOB_LOG_DIR=/root/zubair/jobs

while read MACHINE
do
      CIEL_DIR=$ROOT_DIR/$MACHINE/ciel_data
      LOG_DIR=$CIEL_DIR/logs
      echo "Retrieving log from machine $MACHINE for job $JOBID"
      cat $LOG_DIR/$MACHINE.log | grep $JOBID >> $JOB_LOG_DIR/$JOB_FILENAME

done < $FILENAME
