#!/usr/bin/env bash

# ---- Intel iGPU lock ----
if [ -f /sys/class/drm/card1/gt_max_freq_mhz ]; then
    MAX_FREQ=$(cat /sys/class/drm/card1/gt_max_freq_mhz)
    echo "$MAX_FREQ" | sudo tee /sys/class/drm/card1/gt_min_freq_mhz > /dev/null
fi

# ---- Hyprland: disable effects ----
hyprctl keyword animations:enabled false
hyprctl keyword decoration:blur:enabled false
hyprctl keyword decoration:shadow:enabled false
hyprctl keyword misc:vrr true
#hyprctl keyword general:allow_tearing 1

# ---- Kill Hypridle ----
#pkill hypridle
bash ~/.config/waybar/scripts/toggle-waybar.sh
