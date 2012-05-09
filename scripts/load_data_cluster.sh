#!/bin/bash
#SCRIPT:  load_data_cluster.sh
#PURPOSE: Loads data into the cluster

FILENAME=/root/datasets/2/
MASTER_PORT=http://ciel1:8000
NUM_REPLICAS=2
OUTPUT_FILE=/root/current_uploads.txt

echo "Loading data into cluster"
nohup python /root/ciel/src/python/ciel/runtime/util/load.py -m $MASTER_PORT -r $NUM_REPLICAS $FILENAME >> $OUTPUT_FILE
