#!/bin/bash



chosen=$(echo -e "Logout\nReboot\nShutdown\nLock\nSuspend" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
    Logout) i3-msg exit ;;
    Reboot) reboot ;;
    Shutdown) poweroff ;;
    Lock) i3lock -c 000011 -b ;;
    Suspend)  i3lock -c 000011 -b && systemctl suspend ;;
esac
