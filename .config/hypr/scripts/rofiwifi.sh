#!/usr/bin/env bash

notify-send "Scanning Wi-Fi..."

wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list \
    | sed 1d \
    | sed 's/  */ /g' \
    | sed -E "s/WPA*.?\S/ /g" \
    | sed "s/^--/ /g" \
    | sed "s/  //g" \
    | sed "/--/d")

connected=$(nmcli -fields WIFI g)

if [[ "$connected" =~ enabled ]]; then
    toggle="󰖪  Disable Wi-Fi"
else
    toggle="󰖩  Enable Wi-Fi"
fi

chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID")

[ -z "$chosen_network" ] && exit 0

read -r chosen_id <<< "${chosen_network:3}"

if [[ "$chosen_network" == "󰖩  Enable Wi-Fi" ]]; then
    nmcli radio wifi on
    exit 0
fi

if [[ "$chosen_network" == "󰖪  Disable Wi-Fi" ]]; then
    nmcli radio wifi off
    exit 0
fi

success_message="Connected to \"$chosen_id\""

saved_connections=$(nmcli -g NAME connection)

if echo "$saved_connections" | grep -qw "$chosen_id"; then
    nmcli connection up id "$chosen_id" \
        && notify-send "Wi-Fi" "$success_message"
    exit 0
fi

if [[ "$chosen_network" =~ "" ]]; then
    wifi_password=$(rofi -dmenu -password -p "Password")

    # penting. stop kalau kosong
    [ -z "$wifi_password" ] && exit 0
fi

nmcli device wifi connect "$chosen_id" password "$wifi_password" \
    && notify-send "Wi-Fi" "$success_message"
