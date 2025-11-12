#!/bin/bash

direction=$1
current_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .num')

if [ "$direction" == 'next' ]; then
    if [ "$current_workspace" == '9' ]; then
        current_workspace=1
    else
        current_workspace=$((current_workspace+1))
    fi
elif [ "$direction" == 'prev' ]; then
    if [ "$current_workspace" == '1' ]; then
        current_workspace=9
    else
        current_workspace=$((current_workspace-1))
    fi
fi

swaymsg move container to workspace number "$current_workspace" && swaymsg workspace number "$current_workspace"
