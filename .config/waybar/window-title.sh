#!/bin/bash

title=$(hyprctl activewindow -j | jq -r '.title')

if [ -z "$title" ] || [ "$title" = "null" ]; then
    echo "No window active"
else
    echo "$title"
fi
