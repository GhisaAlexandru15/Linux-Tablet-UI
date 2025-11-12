#!/bin/bash
swaymsg kill
kill $(pgrep wofi)
