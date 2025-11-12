#!/bin/bash

STATUS_FILE="/home/ghisa/.local/bin/rotation_status"

if [ ! -f "$STATUS_FILE" ]; then
    echo "off" > "$STATUS_FILE"
fi

STATUS=$(cat "$STATUS_FILE")

if [[ "$STATUS" == "on" ]]; then
    echo "off" > "$STATUS_FILE"
    notify-send -t 3000 "Auto rotation disabled"
    pkill swayidle
else
    echo "on" > "$STATUS_FILE"
    notify-send -t 3000 "Auto rotation enabled"
fi

