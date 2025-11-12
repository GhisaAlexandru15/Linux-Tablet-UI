#!/bin/bash
sleep 2  # Ensure swayidle has time to start
if [ -f /tmp/swayidle.pid ]; then
    swaymsg "output * power on"  # Just in case
    kill "$(cat /tmp/swayidle.pid)" 2>/dev/null
    rm /tmp/swayidle.pid  # Cleanup
fi
