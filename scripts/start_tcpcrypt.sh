#!/bin/sh

PORT=${1:-80}

TCPCRYPTD=~/tcpcrypt/user/src/tcpcryptd
DIVERT_PORT=$2
PIDFILE=/tmp/tcpcrypt.pid

start_tcpcryptd() {
    LD_LIBRARY_PATH=lib/ $TCPCRYPTD $OPTS -p $DIVERT_PORT &
    echo $! > $PIDFILE
    sleep 1
}

ee() {
    echo $*
    eval $*
}

linux_set_iptables() {
    echo Tcpcrypting port $PORT
    ee iptables -I INPUT  -p tcp --dport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    ee iptables -I INPUT  -p tcp --sport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    ee iptables -I OUTPUT -p tcp --dport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    ee iptables -I OUTPUT -p tcp --sport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
}

        linux_set_iptables
        start_tcpcryptd
