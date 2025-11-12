#!/bin/bash

# Find the PID of the wvkbd-mobintl process
PID=$(ps aux | grep 'wofi --show drun' | grep -v 'grep' | awk '{print $2}')

# Check if the PID exists and kill the process
if [ -n "$PID" ]; then
    kill -9 "$PID"
else
    wofi --show drun --sort-order=alphabetical -bi --hide-search &
    eww close powermenu
    eww close screen
fi
