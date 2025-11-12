#!/bin/bash
  
timestamp=$(date +"%d-%m-%Y_%H:%M:%S")

# Use slurp to select a region
region=$(slurp)
if [ $? -ne 0 ]; then
      echo "Slurp cancelled or failed"
      exit 1
fi

# Define filename
filename=~/Pictures/Screenshots/ss_$timestamp.png

# Take screenshot using grim
grim -g "$region" "$filename"
notify-send -t 3000  "Screenshot saved"



