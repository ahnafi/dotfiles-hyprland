#!/usr/bin/env bash

sel=$(cliphist list | tac | rofi -dmenu -i -p "Clipboard") || exit 0
[ -z "$sel" ] && exit 0

printf '%s' "$sel" | cliphist decode | wl-copy
