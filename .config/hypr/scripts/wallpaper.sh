#!/usr/bin/env bash

set -e

WALL_DIR="$HOME/.config/wal/wallpapers"
DEFAULT_WALL="$HOME/.config/wal/wallpapers/default.jpg"
STATE_FILE="$HOME/.cache/wal/.wall_index"

mkdir -p "$(dirname "$STATE_FILE")"

# ambil semua wallpaper* urut alfabet
mapfile -t WALLS < <(
  find "$WALL_DIR" -maxdepth 1 -type f \
  \( -iname "wallpaper*.jpeg" \
  -o -iname "wallpaper*.png" \
  -o -iname "wallpaper*.gif" \
  -o -iname "wallpaper*.pnm" \
  -o -iname "wallpaper*.tga" \
  -o -iname "wallpaper*.tiff" \
  -o -iname "wallpaper*.webp" \
  -o -iname "wallpaper*.bmp" \
  -o -iname "wallpaper*.farbfeld" \
  -o -iname "wallpaper*.svg" \) | sort
)

TOTAL=${#WALLS[@]}

# baca index lama
if [ -f "$STATE_FILE" ]; then
  idx=$(cat "$STATE_FILE")
else
  idx=0
fi

# naikkan index
idx=$((idx + 1))

# jika lebih dari total wallpaper, reset ke 0 (default)
if [ "$idx" -gt "$TOTAL" ]; then
  idx=0
fi

echo "$idx" > "$STATE_FILE"

# pilih wallpaper
if [ "$idx" -eq 0 ]; then
  wall="$DEFAULT_WALL"
else
  wall="${WALLS[$((idx-1))]}"
fi

[ ! -f "$wall" ] && exit 1

# transition
# ambil posisi cursor (pixel)
pos=$(hyprctl cursorpos -j | jq -r '"\(.x),\(.y)"')

awww img "$wall" \
  --transition-type outer \
  --transition-pos "$pos" \
  --invert-y \
  --transition-step 60 \
  --transition-fps 60

# generate warna wal
$HOME/.local/bin/wal -i "$wall" -n

ln -sfn "$HOME/.cache/wal/colors-hyprland.conf" \
       "$HOME/.config/hypr/configs/colors-hyprland.conf"

ln -sfn "$HOME/.cache/wal/colors-waybar.css" \
       "$HOME/.config/waybar/colors-waybar.css"

ln -sfn "$HOME/.cache/wal/colors-waybar.css" \
       "$HOME/.config/wlogout/colors.css"

ln -sfn "$HOME/.cache/wal/colors-waybar.css" \
       "$HOME/.config/swaync/colors.css"

ln -sfn "$HOME/.cache/wal/colors-rofi-dark.rasi" \
       "$HOME/.config/rofi/themes/colors.rasi"


# reload hyprland config
swaync-client -R && swaync-client -rs
