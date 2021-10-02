#!/usr/bin/env bash

# sudo check

if (( EUID != 0 )); then
    zenity --error --text="Please run as root"
fi

(
    cp application/*  /usr/share/applications/;echo "33"; echo "# installing app...";  \
    cp application/*  ~/Desktop;echo "33"; echo "# installing app...";  \
    cp core /etc/miner ;echo "100"; echo "# installing scripts...";  \
) | zenity --progress --title="Installing miner" --percentage=0 --auto-close && zenity --info --text="Installation done"