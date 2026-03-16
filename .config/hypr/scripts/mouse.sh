#!/bin/bash

COLOR=$(sed -n '7p' ~/.cache/wal/colors | tr -d '#')

BRIGHTNESS=128

# Mouse
MOUSE=$(ratbagctl list | head -n1 | cut -d':' -f1)

if [ -n "$MOUSE" ]; then
    ratbagctl "$MOUSE" led 0 set color "$COLOR"
    ratbagctl "$MOUSE" led 1 set color "$COLOR"
fi

# Keyboard
#openrgb --device 1 --mode direct --color "$COLOR" --brightness $BRIGHTNESS

#echo "RGB synced to #$COLOR at brightness $BRIGHTNESS"
