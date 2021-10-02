#!/usr/bin/env bash

# sudo check

if (( EUID != 0 )); then
    echo "Please run as root"
fi

apt install git zenity curl -y || { exit 1; }

if [ -d miner-linux ]; then
    rm -rf miner-linux
fi

git clone https://github.com/SaicharanKandukuri/miner-linux

cd miner-linux || exit 1
bash install.sh