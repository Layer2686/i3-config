
#!/bin/sh

# Options to display in ROFI
OPTIONS="lock\nlogout\nsuspend\nhibernate\nreboot\nshutdown"

# Show ROFI menu and get the chosen option
CHOICE=$(echo -e $OPTIONS | rofi -theme arc-rofi -dmenu -i -p "Choose action:")

case "$CHOICE" in
    lock)
        i3lock -c 000011 -b
        ;;
    logout)
        i3-msg exit && systemctl --user exit
        ;;
    suspend)
        i3lock -c 000011 -b && systemctl suspend
        ;;
    hibernate)
        i3lock -c 000011 -b && systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        # If no valid choice, just exit
        exit 1
        ;;
esac
