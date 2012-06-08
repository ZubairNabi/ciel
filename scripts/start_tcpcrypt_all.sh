#!/bin/bash
#SCRIPT:  start_tcpcrypt_all.sh
#PURPOSE: Start tcpcrypt on all machines

FILENAME_MASTER=$1
USERNAME=root
CIEL_PORT=8001
PORT=666


echo "Starting TCPcrypt daemon"
sh ~/zubair/ciel/scripts/start_tcpcrypt_host.sh $CIEL_PORT $PORT

while read MASTER
do
      echo "Setting TCPcrypt tables on $MASTER"
      ssh -n $USERNAME@$MASTER "~/ciel/scripts/start_tcpcrypt.sh $CIEL_PORT $PORT"

done < $FILENAME_MASTER
