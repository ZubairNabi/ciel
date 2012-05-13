#!/bin/bash
#SCRIPT:  execute_command_background.sh
#PURPOSE: Execute a command as a daemon on all machines

FILENAME=$1
COMMAND=$2
USERNAME=root

while read MACHINE
do
      echo "Executing $COMMAND on machine $MACHINE"
      ssh -n $MACHINE nohup $COMMAND > foo.out 2> foo.err < /dev/null &

done < $FILENAME
