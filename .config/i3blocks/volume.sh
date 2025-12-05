#!/bin/bash

# Get volume percentage
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)"%"}')

# Detect mouse click
case $BLOCK_BUTTON in
    1) pavucontrol ;; # Left click opens pavucontrol
esac

# Output the volume percentage
echo $volume

