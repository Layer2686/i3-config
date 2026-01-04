#!/bin/sh

# --- CONFIGURATION ---

# 1. Keyboard Layouts
# Force this layout while entering password (avoids typo errors)
LOCK_LAYOUT="us"
# Restore these layouts after unlocking
RESTORE_LAYOUT="us,ua"
# Your toggle key (usually alt_shift_toggle, caps_toggle, or win_space_toggle)
TOGGLE_OPTION="grp:alt_shift_toggle"

# 2. Gentoo Dark Styling (Colors in format AARRGGBB)
# Gentoo Purple: #54487A, Dark Grey: #1f1f1f
BLANK_COLOR="00000000"       # Transparent
CLEAR_COLOR="ffffff22"       # Faint white
DEFAULT_COLOR="54487Aff"     # Gentoo Purple (Ring)
TEXT_COLOR="ffffffff"        # White text
WRONG_COLOR="bb0000bb"       # Red transparency
VERIFYING_COLOR="54487Abb"   # Purple transparency
INSIDE_COLOR="1f1f1fee"      # Dark grey background (solid-ish)

# --- FUNCTIONS ---

# Function to run the styled lock
cool_lock() {
    # 1. Switch to English layout immediately to ensure password acceptance
    setxkbmap $LOCK_LAYOUT

    # 2. Run i3lock-color with Gentoo styling
    # -k: show clock, -B: blur background
    i3lock \
    --blur 5 \
    --clock \
    --indicator \
    --time-str="%H:%M" \
    --date-str="%A, %d %B" \
    --inside-color=$INSIDE_COLOR \
    --ring-color=$DEFAULT_COLOR \
    --line-color=$BLANK_COLOR \
    --keyhl-color="ddddddff" \
    --ringver-color=$VERIFYING_COLOR \
    --separator-color=$BLANK_COLOR \
    --insidever-color=$BLANK_COLOR \
    --ringwrong-color=$WRONG_COLOR \
    --insidewrong-color=$BLANK_COLOR \
    --verif-text="Verifying..." \
    --wrong-text="Nope!" \
    --noinput-text="Empty" \
    --lock-text="Locking..." \
    --lockfailed-text="Lock Failed" \
    --time-color=$TEXT_COLOR \
    --date-color=$TEXT_COLOR \
    --layout-color=$TEXT_COLOR \
    --screen 1

    # 3. Restore US + UA layout after the lock screen closes
    setxkbmap -layout $RESTORE_LAYOUT -option $TOGGLE_OPTION
}

# --- MENU LOGIC ---

OPTIONS="lock\nlogout\nsuspend\nhibernate\nreboot\nshutdown"

# Using rofi (since your comment mentioned ROFI). 
# If you prefer dmenu, uncomment the dmenu line instead.
CHOICE=$(echo -e "$OPTIONS" | dmenu -l 10 -c) 

case "$CHOICE" in
    lock)
        cool_lock
        ;;
    logout)
        i3-msg exit && systemctl --user exit
        ;;
    suspend)
        cool_lock && systemctl suspend
        ;;
    hibernate)
        cool_lock && systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        exit 1
        ;;
esac
