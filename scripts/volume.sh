#!/bin/bash

SCREEN_STATUS=$(cat ~/.local/bin/status/screen)
WINDOW_NAME="volume-bar"
TIMEOUT=3
TIMER_FILE="/tmp/eww_volume_timer.pid"
STEP=5   # change per key press, in percent
# Get current volume (0-100)
current=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'[/]' 'NR==1 {gsub(/ /,"",$2); print $2+0}')
# Adjust volume based on argument
case "$1" in
    up)
        new=$((current + STEP))
        ;;
    down)
        new=$((current - STEP))
        ;;
    *)
        echo "Usage: $0 up|down"
        exit 1
        ;;
esac

# Cap volume to 0-100
if (( new > 100 )); then new=100; fi
if (( new < 0 )); then new=0; fi

# Set the new volume
pactl set-sink-volume @DEFAULT_SINK@ "$((new))%"
# Open the window if not already open
if (( new == 0 )); then pactl set-sink-mute @DEFAULT_SINK@ 1; fi
if (( new > 0 && current ==0)); then pactl set-sink-mute @DEFAULT_SINK@ 0; fi
# Kill previous timer if exists
if [[ -f "$TIMER_FILE" ]]; then
    kill "$(cat $TIMER_FILE)" 2>/dev/null
else 
    eww open "$WINDOW_NAME"
fi

# Start new timer in background
(
    sleep "$TIMEOUT"
    eww close "$WINDOW_NAME"
    rm -f "$TIMER_FILE"
) &

# Save PID of timer
echo $! > "$TIMER_FILE"
if (( SCREEN_STATUS == 0 )); then 
    ~/.local/bin/Screen_Lock/screen_lock.sh
fi
