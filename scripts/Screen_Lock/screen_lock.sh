#!/bin/bash
SCREEN_STATUS=$(cat ~/.local/bin/status/screen)
if (( SCREEN_STATUS == 1 )); then
pkill swayidle
echo 0 > ~/.local/bin/status/screen
source ~/.venvs/venv/bin/activate && python3 ~/.local/bin/Screen_Lock/screen_lock.py $1 && deactivate
echo 1 > ~/.local/bin/status/screen
pkill swayidle
swayidle -w timeout 590 'notify-send -t 5000 "Closing screen in 10s"' & 
swayidle -w timeout 595 'notify-send -t 2000 "Closing screen in 5s"' & 
swayidle -w timeout 597 'notify-send -t 1000 "Closing screen in 3s"' & 
swayidle -w timeout 598 'notify-send -t 1000 "Closing screen in 2s"' & 
swayidle -w timeout 599 'notify-send -t 1000 "Closing screen in 1s"' & 
swayidle -w timeout 600 '~/.local/bin/Screen_Lock/screen_lock.sh'
else
    wlr-randr --output DSI-1 --on && sleep 0.37 && ydotool mousemove -a 600 300 && ydotool click 0xC0
fi
