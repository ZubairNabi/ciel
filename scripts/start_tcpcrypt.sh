#!/bin/sh

OSNAME=`uname -s`
PORT=${1:-80}

TCPCRYPTD=`dirname $0`/src/tcpcryptd
DIVERT_PORT=666
PIDFILE=/tmp/tcpcrypt.pid

start_tcpcryptd() {
    LD_LIBRARY_PATH=lib/ $TCPCRYPTD $OPTS -p $DIVERT_PORT &
    echo $! > $PIDFILE
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
