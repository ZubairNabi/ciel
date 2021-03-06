#!/bin/sh

PORT=$1
DIVERT_PORT=$2

ee() {
    echo $*
    eval $*
}

linux_set_iptables() {
    echo Tcpcrypting port $PORT
    ee iptables -I INPUT  -p tcp --sport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    ee iptables -I OUTPUT -p tcp --dport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
}

        linux_set_iptables
