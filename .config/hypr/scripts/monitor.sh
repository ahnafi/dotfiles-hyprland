#!/usr/bin/env bash

# choice=$(printf "Extend\nMirror\nLaptop Only\nHDMI Only" | rofi -dmenu -p "Monitor")
choice=$(printf "Extend\nMirror\nLaptop Only" | rofi -dmenu -p "Monitor")

case "$choice" in
  Extend)
    hyprctl keyword monitor "eDP-1,1920x1080,0x0,1"
    hyprctl keyword monitor "HDMI-A-1,1920x1080,1920x0,1"
    ;;
  Mirror)
    hyprctl keyword monitor "eDP-1,1920x1080,0x0,1"
    hyprctl keyword monitor "HDMI-A-1,1920x1080,0x0,1"
    ;;
  "Laptop Only")
    hyprctl keyword monitor "HDMI-A-1,disable"
    ;;
  # "HDMI Only")
  #   hyprctl keyword monitor "eDP-1,disable"
  #   hyprctl keyword monitor "HDMI-A-1,1920x1080,0x0,1"
  #   ;;
esac
