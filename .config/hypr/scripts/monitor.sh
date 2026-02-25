#!/usr/bin/env bash

CONF="$HOME/.config/hypr/monitors.conf"

choice=$(printf "Extend\nMirror\nLaptop Only" | rofi -dmenu -p "Monitor")

case "$choice" in
  Mirror)
    cat > "$CONF" <<EOF
# laptop monitor
monitor = eDP-1, preferred, 0x0, 1

# hdmi mirror laptop
monitor = HDMI-A-2, preferred, auto, 1, mirror, eDP-1
EOF
    ;;

  Extend)
    cat > "$CONF" <<EOF
# laptop monitor
monitor = eDP-1, preferred, 0x0, 1

# hdmi extended right of laptop
monitor = HDMI-A-2, preferred, 1920x0, 1
EOF
    ;;

  "Laptop Only")
    cat > "$CONF" <<EOF
# laptop only
monitor = eDP-1, preferred, 0x0, 1
monitor = HDMI-A-2, disable
EOF
    ;;
esac

hyprctl reload
