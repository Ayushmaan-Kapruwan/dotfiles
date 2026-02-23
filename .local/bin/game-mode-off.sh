#!/usr/bin/env bash

# ---- Restore Intel iGPU ----
if [ -f /sys/class/drm/card1/gt_min_freq_mhz ]; then
    echo 300 | sudo tee /sys/class/drm/card1/gt_min_freq_mhz > /dev/null
fi

# ---- Restore Hyprland effects ----
hyprctl keyword general:allow_tearing false
hyprctl reload
#hypridle &
bash ~/.config/waybar/scripts/toggle-waybar.sh
