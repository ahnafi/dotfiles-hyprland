#!/usr/bin/env bash

TIMEOUT=5

terminate_clients() {
    client_pids=$(hyprctl clients -j | jq -r '.[].pid')

    for pid in $client_pids; do
        kill -15 "$pid" 2>/dev/null
    done

    start=$(date +%s)

    for pid in $client_pids; do
        while kill -0 "$pid" 2>/dev/null; do
            now=$(date +%s)
            if [ $((now - start)) -ge $TIMEOUT ]; then
                kill -9 "$pid" 2>/dev/null
                break
            fi
            sleep 0.5
        done
    done
}

case "$1" in
    exit)
        terminate_clients
        hyprctl dispatch exit
        ;;

    lock)
        hyprlock
        ;;

    reboot)
        terminate_clients
        systemctl reboot
        ;;

    shutdown)
        terminate_clients
        systemctl poweroff
        ;;

    suspend)
        /usr/bin/hyprlock &
        sleep 1
        systemctl suspend
        ;;

esac
