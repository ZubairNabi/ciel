#!/bin/bash
#SCRIPT:  refresh_worker_logs.sh
#PURPOSE: Refresh the log on all workers

FILENAME=$1
USERNAME=root

while read MACHINE
do
      echo "Refreshing log of $MACHINE"
      ssh -n $MACHINE 'cat /dev/null > ~/ciel_logs/log_ciel*'

done < $FILENAME
