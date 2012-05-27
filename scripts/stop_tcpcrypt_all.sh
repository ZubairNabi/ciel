#!/bin/bash
#SCRIPT:  stop_tcpcrypt_all.sh
#PURPOSE: Stop tcpcrypt on all machines

FILENAME_MASTER=$1
USERNAME=root
PORT=32768

while read MASTER
do
      echo "Stopping TCPcrypt on $MASTER"
      ssh -n $USERNAME@$MASTER "~/ciel/scripts/stop_tcpcrypt.sh 80 $PORT"
      PORT=`expr $PORT + 1`

done < $FILENAME_MASTER
