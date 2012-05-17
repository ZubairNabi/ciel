#!/bin/bash
#SCRIPT:  create_root_dirs.sh
#PURPOSE: Create root directory structure for containers

FILENAME=$1

ROOT_DIR=/mnt/ssd/ssd

while read MACHINE
do
      echo "Creating folder structure for container $MACHINE"
      mkdir $ROOT_DIR/$MACHINE
done < $FILENAME
