#!/bin/bash
#SCRIPT:  stop_tcpcrypt_all.sh
#PURPOSE: Stop tcpcrypt on all machines

FILENAME_MASTER=$1
USERNAME=root

while read MASTER
do
      echo "Stopping TCPcrypt on $MASTER"
      ssh -n $USERNAME@$MASTER '~/ciel/scripts/stop_tcpcrypt.sh'

done < $FILENAME_MASTER
