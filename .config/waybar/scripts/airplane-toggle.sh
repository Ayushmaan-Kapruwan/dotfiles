#!/usr/bin/env bash

# Check current Wi-Fi state
WIFI_STATE=$(nmcli -t -f WIFI g)

if [ "$WIFI_STATE" = "enabled" ]; then
    # Turn OFF (airplane mode)
    nmcli radio all off
    bluetoothctl power off
    notify-send "Airplane Mode" "Wi-Fi & Bluetooth OFF"
else
    # Turn ON
    nmcli radio all on
    bluetoothctl power on
    notify-send "Airplane Mode" "Wi-Fi & Bluetooth ON"
fi
