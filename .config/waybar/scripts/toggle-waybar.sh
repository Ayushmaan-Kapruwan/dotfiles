#!/bin/bash

if pidof waybar > /dev/null;then
    killall waybar
    killall bongocat
    #killall qs
else
  waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &
  #qs &
fi
