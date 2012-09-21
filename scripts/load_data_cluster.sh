#!/bin/bash
#SCRIPT:  load_data_cluster.sh
#PURPOSE: Loads data into the cluster

FILENAME=/mnt/s3/datasets/1/
MASTER_PORT=$1
#MASTER_PORT=http://ciel1:8000
NUM_REPLICAS=1
OUTPUT_FILE=/state/partition1/current_uploads.txt

echo "Loading data into cluster"
nohup python /state/partition1/ciel/src/python/ciel/runtime/util/load.py -m "http://$MASTER_PORT:8000" -r $NUM_REPLICAS $FILENAME >> $OUTPUT_FILE
