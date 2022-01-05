#!/bin/sh

toggler=0
sleep_pid=0

toggle() {
    toggler=$(((toggler + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

while true; do
    if [ $toggler -eq 0 ]; then
        echo "$(date +"  %H:%M")"
    else
        echo "$(date +"  %a, %-d %b    %H:%M")"
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done
