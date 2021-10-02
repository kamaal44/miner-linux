#!/usr/bin/env bash
echo "script ${0} started...."
source /etc/miner/conf.sh

function connect_to_wifi() {
    local msg
    echo "Connecting to wifi..."
    msg=$(curl -L -i -s -k -X $'POST' \
    -H $'Host: 10.0.0.11:8090' -H $'Content-Length: 77' -H $'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36' -H $'Content-Type: application/x-www-form-urlencoded' -H $'Accept: */*' -H $'Origin: http://10.0.0.11:8090' -H $'Referer: http://10.0.0.11:8090/' -H $'Accept-Encoding: gzip, deflate' -H $'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' -H $'Connection: close' \
    --data-binary $'mode=191&username=${USERNAME}&password=${PASSWORD}&a=1630404423764&producttype=0' \
    $'http://10.0.0.11:8090/login.xml')
}

function check_internet() {
    ping -c 1 -q google.com >&/dev/null; return $?
}
function check_connection_to_pool()
{
    ping -c 1 -q google.com >&/dev/null; return $?
}

function logic_loop() {
    sleep 10
    if ! check_internet; then
        zenity --notification --text="Internet is down. retrying..."
        connect_to_wifi
        if ! check_internet; then
            zeity --notification --text="Internet is down. Giving up"
            systemctl stop /etc/miner/kalive.service
        fi
        echo "Recived: ${msg}"
        if ! check_connection_to_pool; then
            zenity --error --text="Looks like mining pool is down.."
        else
            logic_loop
        fi
    else
        logic_loop
    fi
}

logic_loop