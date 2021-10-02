#!/usr/bin/env bash
TREX_DIR="/etc/miner/t-rex/t-rex"
source /etc/miner/conf.sh

if [ ! -f "$TREX_DIR" ]; then
    zenity --error --text="T-Rex not found in $TREX_DIR"
    exit 1
fi

if [ -z "$USERNAME" ];then
    zenity --error --text="Please set USERNAME in /etc/miner/conf.sh"
    exit 2
fi
if [ -z "$PASSWORD" ];then
    zenity --error --text="Please set PASSWORD in /etc/miner/conf.sh"
    exit 3
fi
if [ -z "$ADDRESS" ]; then
    zenity --error --text="Please set ADDRESS in /etc/miner/conf.sh"
    exit 4
fi

/etc/miner/internet.sh & shift 1
zenity --info --text="Starting internet script"

zenity --notification --text="Starting mining at $ADDRESS"

. ${TREX_DIR} \
    -a etchash \
    -o stratum+tcp://asia1-etc.ethermine.org:4444 \
    -u "${ADDRESS}" \
    -p x \
    --validate-shares \
    --mt 3 \
    -i 25 || {
        zenity --error --text="T-Rex failed or stopped"
    }