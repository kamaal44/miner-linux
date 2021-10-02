#!/usr/bin/env bash

# sudo check

if (( EUID != 0 )); then
    zenity --error --text="Please run as root"
fi

(
    cp applications/*  /usr/share/applications/;echo "33"; echo "# installing app...";  \
    cp applications/*  ~/Desktop;echo "33"; echo "# installing app...";  \
    cp -r core /etc/miner ;echo "100"; echo "# installing scripts...";  \
) | zenity --progress --title="Installing miner" 

zenity --info --text="Installation done"