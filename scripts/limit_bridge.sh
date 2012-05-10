#!/bin/bash
#SCRIPT:  limit_bridge.sh
#PURPOSE: Limits the QoS of a switch

RATE=$2
BRIDGE=$1

echo "Setting rate of $BRIDGE to $RATE"
ovs-vsctl -- set port $BRIDGE qos=@newqos -- --id=@newqos create qos type=linux-htb other-config:max-rate=$RATE queues:0=@newqueue -- --id=@newqueue create queue other-config:min-rate=$RATE other-config:max-rate=$RATE

