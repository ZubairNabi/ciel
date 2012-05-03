#!/bin/bash
#SCRIPT:  transfer_lxc.sh
#PURPOSE: Transfer a file to all containers

FILENAME=$1
FILETRANSFER=$2
USERNAME=root

while read MACHINE
do
      echo "Transferring $FILETRANSFER to container $MACHINE"
      tar cfz - $FILETRANSFER | ssh $MACHINE tar xzf - -C /root/

done < $FILENAME
