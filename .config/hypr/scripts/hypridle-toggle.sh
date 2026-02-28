#!/usr/bin/env bash

if pgrep -x hypridle > /dev/null; then
  pkill -x hypridle
  notify-send "Idle turned off"
else 
  hypridle &
  notify-send "Idle turned on"
fi 

