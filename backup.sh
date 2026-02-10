#!/usr/bin/env sh

SRC="$HOME/.config"
DST="$HOME/code/dotfiles-hyprland/.config"

echo "hapus backup lama"
rm -rf "$DST"

echo "buat folder baru"
mkdir -p "$DST"

copy_dir () {
    [ -d "$SRC/$1" ] && cp -r "$SRC/$1" "$DST/"
}

copy_file () {
    [ -f "$SRC/$1" ] && cp "$SRC/$1" "$DST/"
}

echo "backup mulai"

copy_dir hypr
copy_dir kitty
copy_dir btop
copy_dir gtk-3.0
copy_dir gtk-4.0
copy_dir waybar
copy_dir wlogout
copy_dir pipewire
copy_dir rofi

copy_file mimeapps.list

echo "backup selesai di $DST"
