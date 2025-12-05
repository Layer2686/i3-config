#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Polybar on each connected monitor
for m in $(polybar --list-monitors | cut -d":" -f1); do
  #MONITOR=$m polybar mybar &
  polybar
done

echo "Polybar launched on all monitors"
