#!/bin/bash

# Use xprop to get the name of the currently focused window
window_id=$(xdotool getwindowfocus)
window_name=$(xprop -id $window_id WM_NAME | cut -d '"' -f 2)

# If no window is focused, set it to an empty string
if [ "$window_name" == "WM_NAME:  not found." ]; then
  window_name=" "
fi

echo "$window_name"
