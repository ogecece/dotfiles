#!/bin/sh

toggler=0
sleep_pid=0

DATE="$(date +"  %H:%M")"
FULL_DATE="$(date +"  %a, %-d %b    %H:%M")"

toggle() {
    toggler=$(((toggler + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}


trap "toggle" USR1

while true; do
    if [ $toggler -eq 0 ]; then
        echo "$DATE"
    else
        echo "$FULL_DATE"
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done
