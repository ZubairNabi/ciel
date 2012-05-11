#!/bin/bash
#SCRIPT:  delete_ovs_db.sh
#PURPOSE: Deletes and reinstalls the OVS DB


echo "Reinstalling OVS"
kill `cd /usr/local/var/run/openvswitch && cat ovsdb-server.pid ovs-vswitchd.pid`
rm -Rf /usr/local/etc/openvswitch
mkdir -p /usr/local/etc/openvswitch
ovsdb-tool create /usr/local/etc/openvswitch/conf.db /root/zubair/openvswitch-1.4.0/vswitchd/vswitch.ovsschema
