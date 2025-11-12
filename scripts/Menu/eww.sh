#!/bin/bash

# Find the PID of the wvkbd-mobintl process
PID=$(ps aux | grep 'wofi --show drun' | grep -v 'grep' | awk '{print $2}')

# Check if the PID exists and kill the process
if [ -n "$PID" ]; then
    kill -9 "$PID"
fi
widgets=("powermenu" "screen")

for widget in ${widgets[@]}; do
    if [ "$widget" != "$1" ]; then
  	eww close "$widget"
    fi
done

eww open --toggle $1
