#!/bin/bash
#SCRIPT:  retrieve_job_logs.sh
#PURPOSE: Retrieve logs for a particular job from all machines

FILENAME=$1
JOBID=$2

CIEL_DIR=/mnt/ciel_data
#CIEL_DIR=/root/ciel_data
LOG_DIR=$CIEL_DIR/logs
JOB_LOG_DIR=$CIEL_DIR/jobs
JOB_FILENAME=$JOBID.log

while read MACHINE
do
      echo "Retrieving log from machine $MACHINE for job $JOBID"
      ssh -n $MACHINE "cat $LOG_DIR/$MACHINE.log | grep $JOBID" >> $JOB_LOG_DIR/$JOB_FILENAME

done < $FILENAME
