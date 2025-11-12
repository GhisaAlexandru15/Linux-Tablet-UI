#!/bin/bash

# Get all PIDs of wvkbd-mobintl processes
PIDS=$(pgrep -f wvkbd-mobintl)

if [ -n "$PIDS" ]; then
    # Kill all found processes
    echo "Killing wvkbd-mobintl processes: $PIDS"
    kill $PIDS
else
    # Start the process if none are running
    echo "Starting wvkbd-mobintl"
    wvkbd-mobintl --bg d8cab8 -fg 77b1e1 -fg-sp 1791d1 --alpha 220 -H 300 -L 200 --fn 16 &
fi

