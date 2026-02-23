#!/bin/bash

# Get the current status of warp-cli
STATUS=$(warp-cli status | grep -i "Status update:" | awk '{print $3}')

if [ "$STATUS" = "Connected" ]; then
    warp-cli disconnect
    notify-send "Cloudflare WARP" "Disconnected" -i network-wireless-offline
else
    warp-cli connect
    notify-send "Cloudflare WARP" "Connected" -i network-wireless-hotspot
fi
