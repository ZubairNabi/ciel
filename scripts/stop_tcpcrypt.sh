#!/bin/sh

PORT=$1
DIVERT_PORT=$2

linux_unset_iptables() {
    echo Removing iptables rules
    iptables -D INPUT  -p tcp --sport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    iptables -D OUTPUT -p tcp --dport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
}

        linux_unset_iptables
