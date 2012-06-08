#!/bin/bash
#SCRIPT:  stop_tcpcrypt_all.sh
#PURPOSE: Stop tcpcrypt on all machines

FILENAME_MASTER=$1
PORT=666
CIEL_PORT=8001


echo "Stopping TCPcrypt daemon"
sh ~/zubair/ciel/scripts/stop_tcpcrypt_host.sh $CIEL_PORT $PORT

while read MASTER
do
      echo "Removing TCPcrypt rules on $MASTER"
      ssh -n $MASTER "~/ciel/scripts/stop_tcpcrypt.sh $CIEL_PORT $PORT"

done < $FILENAME_MASTER
