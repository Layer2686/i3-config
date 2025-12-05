
#!/bin/bash

# Kill any running Polybar instances
killall -q polybar

# Wait for processes to terminate
while pgrep -x polybar >/dev/null; do sleep 0.1; done

# Track used positions to avoid mirrored monitors
declare -A positions=()

if type "xrandr" >/dev/null; then
  while read -r line; do
    # Extract monitor name and position (e.g., HDMI-1 1920x1080+0+0)
    name=$(echo $line | cut -d' ' -f1)
    geometry=$(echo $line | grep -o '[0-9]\+x[0-9]\++[0-9]\++[0-9]\+')

    # Only run Polybar if this geometry hasn't been used yet
    if [[ -n "$geometry" && -z "${positions[$geometry]}" ]]; then
      positions[$geometry]=1
      MONITOR=$name polybar --reload i3 &
    fi
  done <<< "$(xrandr --query | grep " connected")"
else
  polybar --reload i3 &
fi
