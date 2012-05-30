#!/bin/bash
#SCRIPT:  setup_mptcp_tables_all.sh
#PURPOSE: Setup MPTCP routing tables on all machiens

FILENAME=$1
INTF1=101
INTF2=201

while read MACHINE
do
      echo "Setting up MPTCP routing tables on $MACHINE"
      ssh -n $MACHINE "~/ciel/scripts/setup_mptcp_tables.sh $INTF1 $INTF2"
      INTF1=`expr $INTF1 + 1`
      INTF2=`expr $INTF2 + 1`

done < $FILENAME
