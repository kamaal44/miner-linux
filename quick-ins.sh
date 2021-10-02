#!/usr/bin/env bash

# sudo check

if (( EUID != 0 )); then
    echo "Please run as root"
fi

if ! command -v git zenity curl >/dev/null 2>&1; then
    apt install git zenity curl -y || { exit 1; }
fi

if [ -d miner-linux ]; then
    rm -rf miner-linux
fi

git clone https://github.com/SaicharanKandukuri/miner-linux

cd miner-linux || exit 1
bash install.sh