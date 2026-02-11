# Fedora Hyprland configuration

## dependencies 

### copr repo

```bash
copr.fedorainfracloud.org/solopasha/hyprland
copr.fedorainfracloud.org/acidburnmonkey/hyprland (disabled)
copr.fedorainfracloud.org/bieszczaders/kernel-cachyos-addons
copr.fedorainfracloud.org/bieszczaders/kernel-cachyos
copr.fedorainfracloud.org/erikreider/SwayNotificationCenter
copr.fedorainfracloud.org/lkiesow/noise-suppression-for-voice
copr.fedorainfracloud.org/erikreider/swayosd
copr.fedorainfracloud.org/scottames/awww
copr.fedorainfracloud.org/che/nerd-fonts
```

### software dependencies

These are just some of the dependencies. Feel free to install any others you might need yourself.

```bash
sudo dnf install \
hyprland sddm tuned tuned-ppd alacritty \
waybar hyprpolkitagent rofi pipewire hyprpaper \
hyprlock hypridle qt5-wayland qt6-wayland swaync\
python-pip python-gobject python-screeninfo brightnessctl\
imagemagick blueman polkit-gnome zsh swayosd cliphist awww wl-clipboard  \
pywal16 wlogout nautilus obs-studio btop\

```
and more
