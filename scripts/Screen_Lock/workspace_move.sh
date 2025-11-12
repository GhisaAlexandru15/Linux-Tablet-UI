#!/bin/bash
SCREEN_STATUS=$(cat ~/.local/bin/status/screen)
if (( SCREEN_STATUS == 1 )); then 
     swaymsg "move container to workspace number $1"
fi
