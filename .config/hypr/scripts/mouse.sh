#!/bin/bash

# 1. Automatically find your Logitech mouse name
# This grabs the first device name from 'ratbagctl list'
MOUSE_NAME=$(ratbagctl list | cut -f1 -d:)

if [ -z "$MOUSE_NAME" ]; then
    echo "No mouse detected by ratbagctl."
    exit 1
fi

# 2. Extract Color6 from pywal and strip the '#'
COLOR6=$(sed -n '7p' ~/.cache/wal/colors | sed 's/#//g')

# 3. Apply color to both common LED zones
# ratbagctl <device> led <index> set color <RRGGBB>
ratbagctl "$MOUSE_NAME" led 0 set color "$COLOR6"
ratbagctl "$MOUSE_NAME" led 1 set color "$COLOR6"

echo "Piper/ratbagctl synced $MOUSE_NAME LEDs to #$COLOR6"
