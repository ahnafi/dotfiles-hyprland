#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 --title | --arturl | --artist | --length | --album | --status | --source | --cover"
	exit 1
fi

# ambil player aktif pertama (punyamu firefox.instance_*)
PLAYER=$(playerctl -l | head -n1)

get_metadata() {
	playerctl -p "$PLAYER" metadata --format "{{ $1 }}" 2>/dev/null
}

get_source_info() {
	name=$(echo "$PLAYER" | tr '[:upper:]' '[:lower:]')

	if [[ "$name" == firefox* ]]; then
		echo "Zen/Firefox 󰈹"
	elif [[ "$name" == spotify* ]]; then
		echo "Spotify "
	elif [[ "$name" == chromium* || "$name" == chrome* ]]; then
		echo "Chrome "
	else
		echo "$PLAYER"
	fi
}

case "$1" in
--title)
	echo "$(get_metadata xesam:title | cut -c1-28)"
	;;

--arturl)
	url=$(get_metadata mpris:artUrl)
	[[ "$url" == file://* ]] && url=${url#file://}
	echo "$url"
	;;

--cover)
	COVER="/tmp/hyde-mpris.png"
	COVER_INF="/tmp/hyde-mpris.inf"
	url=$(get_metadata mpris:artUrl)
	if [ -n "$url" ]; then
		if [[ "$url" == file://* ]]; then
			url=${url#file://}
			cp "$url" "$COVER" 2>/dev/null
		elif [[ "$url" == http* ]]; then
			# Only download if URL changed
			if [[ ! -f "$COVER_INF" ]] || [[ "$(cat "$COVER_INF")" != "$url" ]]; then
				curl -so "$COVER" "$url" 2>/dev/null && echo "$url" > "$COVER_INF"
			fi
		elif [[ "$url" == /* ]]; then
			# Bare local path without file:// prefix
			cp "$url" "$COVER" 2>/dev/null
		fi
	fi
	echo "$COVER"
	;;

--artist)
	echo "$(get_metadata xesam:artist | cut -c1-30)"
	;;

--length)
	length=$(get_metadata mpris:length)
	[[ -n "$length" ]] && echo "$(echo "$length / 1000000 / 60" | bc -l) m"
	;;

--status)
	status=$(playerctl -p "$PLAYER" status 2>/dev/null)
	[[ $status == Playing ]] && echo "󰎆"
	[[ $status == Paused ]] && echo "󱑽"
	;;

--album)
	get_metadata xesam:album
	;;

--source)
	get_source_info
	;;

*)
	echo "Invalid option"
	exit 1
	;;
esac
