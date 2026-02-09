#!/usr/bin/env bash

sel=$(cliphist list | tac | rofi -dmenu -i -p "Clipboard")
[ -z "$sel" ] && exit 0

echo "$sel" | cliphist decode | wl-copy
