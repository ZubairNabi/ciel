#!/bin/bash
#SCRIPT:  start_tcpcrypt_all.sh
#PURPOSE: Start tcpcrypt on all machines

FILENAME_MASTER=$1
USERNAME=root
CIEL_PORT=8001
PORT=32768

while read MASTER
do
      echo "Starting TCPcrypt on $MASTER"
      ssh -n $USERNAME@$MASTER "~/ciel/scripts/start_tcpcrypt.sh $CIEL_PORT $PORT"
      PORT=`expr $PORT + 1` 

done < $FILENAME_MASTER
