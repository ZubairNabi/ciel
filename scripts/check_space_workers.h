#!/bin/bash
#SCRIPT:  check_space_workers.sh
#PURPOSE: Check space on workers

FILENAME=$1
USERNAME=root


while read MACHINE
do
      echo "Showing space on $MACHINE"
      ssh -n $MACHINE df -h

done < $FILENAME
