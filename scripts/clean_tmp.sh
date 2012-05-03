#!/bin/bash
#SCRIPT:  clean_tmp.sh
#PURPOSE: Remove all CIEL files from tmp folder

FILENAME=$1
USERNAME=root

while read MACHINE
do
      echo "Cleaning temp folder on container $MACHINE"
      ssh -n $MACHINE 'cd /tmp; rm -Rf ciel*; rm -Rf spill*; rm -Rf reduce*; rm -Rf *.jar'

done < $FILENAME
