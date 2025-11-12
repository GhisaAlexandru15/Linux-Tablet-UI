#!/bin/bash
pactl get-sink-volume @DEFAULT_SINK@ | awk -F'[/]' 'NR==1 {gsub(/ /,"",$2); print $2+0}'

