#!/bin/bash
#SCRIPT:  start_tcpcrypt_all.sh
#PURPOSE: Start tcpcrypt on all machines

FILENAME_MASTER=$1
USERNAME=root
PORT=32768

while read MASTER
do
      echo "Starting TCPcrypt on $MASTER"
      ssh -n $USERNAME@$MASTER "~/ciel/scripts/start_tcpcrypt.sh 80 $PORT"
      PORT=`expr $PORT + 1` 

done < $FILENAME_MASTER
