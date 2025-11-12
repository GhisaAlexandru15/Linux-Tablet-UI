#!/bin/bash

STATUS_FILE="/home/ghisa/.local/bin/status/screenlock"

# Initialize status file if it doesn't exist
if [ ! -f "$STATUS_FILE" ]; then
    echo "off" > "$STATUS_FILE"
fi

STATUS=$(cat "$STATUS_FILE")

if [[ "$STATUS" == "on" ]]; then
    echo "off" > "$STATUS_FILE"
    notify-send -t 3000 "Lock screen disabled"
    pkill swayidle
else
    echo "on" > "$STATUS_FILE"
    notify-send -t 3000 "Lock screen enabled"
    swayidle -w timeout 600 '~/.local/bin/Screen_Lock/screen_lock.sh'
fi

