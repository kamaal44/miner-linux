#!/usr/bin/env bash
TREX_DIR="/etc/miner/t-rex/t-rex"

if [ ! -f "$TREX_DIR" ]; then
    zenity --error --text="T-Rex not found in $TREX_DIR"
fi

zenity --notification --text="Starting mining at 0xab23Fb2e3db2EEBe03eBfF48e2496f2D426A685E"

${TREX_DIR} \
    -a etchash \
    -o stratum+tcp://asia1-etc.ethermine.org:4444 \
    -u 0xab23Fb2e3db2EEBe03eBfF48e2496f2D426A685E \
    -p x \
    --validate-shares \
    --mt 3 \
    -i 25