#!/bin/bash

# Find the battery device
BAT_PATH=""
for bat in /sys/class/power_supply/BAT*/; do
	if [ -f "${bat}capacity" ]; then
		BAT_PATH="$bat"
		break
	fi
done

# Exit gracefully if no battery found
if [ -z "$BAT_PATH" ]; then
	echo "No Battery"
	exit 0
fi

# Get the current battery percentage
battery_percentage=$(cat "${BAT_PATH}capacity" 2>/dev/null)

# Get the battery status (Charging or Discharging)
battery_status=$(cat "${BAT_PATH}status" 2>/dev/null)

# Exit if we couldn't read battery info
if [ -z "$battery_percentage" ]; then
	echo "N/A"
	exit 0
fi

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	battery_icon="$charging_icon"
fi

# Output the battery percentage and icon
echo "$battery_percentage% $battery_icon"
