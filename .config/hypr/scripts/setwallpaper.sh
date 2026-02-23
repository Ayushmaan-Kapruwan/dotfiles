#!/bin/bash

#The location of your current wallpaper file
CURRENT_WALLPAPER="$HOME/.cache/current_wallpaper" 

if [ -f "$CURRENT_WALLPAPER" ]; then
    swww img "$CURRENT_WALLPAPER" --transition-type none
fi
