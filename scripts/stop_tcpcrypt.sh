#!/bin/sh

PORT=${1:-80}

DIVERT_PORT=$2
PIDFILE=/tmp/tcpcrypt.pid

stop_tcpcryptd() {
    PID=`cat /tmp/tcpcrypt.pid`
    kill $PID
}

linux_unset_iptables() {
    echo Removing iptables rules and quitting tcpcryptd...
    iptables -D INPUT  -p tcp --dport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    iptables -D INPUT  -p tcp --sport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    iptables -D OUTPUT -p tcp --dport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
    iptables -D OUTPUT -p tcp --sport $PORT -j NFQUEUE --queue-num $DIVERT_PORT
}

        linux_unset_iptables
        stop_tcpcryptd
