#!/usr/bin/env bash

DIR="$HOME/Pictures/screenshot"
mkdir -p "$DIR"

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
file="$DIR/$timestamp.png"

notify() {
    notify-send "Screenshot" "Tersimpan di $file dan sudah dicopy"
}

copy_clip() {
    wl-copy < "$file"
}

full() {
    grim "$file" &&
    copy_clip &&
    notify
}

area() {
    region=$(slurp) || exit 0
    grim -g "$region" "$file" &&
    copy_clip &&
    notify
}

active() {
    monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true).name')
    grim -o "$monitor" "$file" &&
    copy_clip &&
    notify
}

delay() {
    sleep "$2"
    "$1"
}

case "$1" in
    full)
        full
        ;;
    area)
        area
        ;;
    active)
        active
        ;;
    delay-full)
        delay full "$2"
        ;;
    delay-area)
        delay area "$2"
        ;;
    *)
        echo "usage: screenshot.sh {full|area|active|delay-full N|delay-area N}"
        ;;
esac

