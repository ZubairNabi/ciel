#!/bin/bash
#SCRIPT:  start_tcpcrypt_all.sh
#PURPOSE: Start tcpcrypt on all machines

FILENAME_MASTER=$1
USERNAME=root

while read MASTER
do
      echo "Starting TCPcrypt on $MASTER"
      ssh -n $USERNAME@$MASTER '~/ciel/scripts/start_tcpcrypt.sh'

done < $FILENAME_MASTER
