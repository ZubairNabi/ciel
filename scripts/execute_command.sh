#!/bin/bash
#SCRIPT:  execute_command.sh
#PURPOSE: Execute a command on all machines

FILENAME=$1
COMMAND=$2
USERNAME=root

while read MACHINE
do
      echo "Executing $COMMAND on machine $MACHINE"
      ssh -n $MACHINE $COMMAND

done < $FILENAME
