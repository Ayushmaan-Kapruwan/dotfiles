#!/usr/bin/env bash

# Get volume & mute state
read -r _ vol muted <<< "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $1, int($2*100), $3}')"

# Detect bluetooth sink
DEFAULT_SINK_NAME=$(wpctl status | awk '
  $1 == "*" { 
    sub(/^[*[:space:]]+[0-9]+\. /, "", $0)
    sub(/  \[vol:.*/, "", $0)
    print
  }
')

if wpctl status | grep -F "$DEFAULT_SINK_NAME" | grep -q "\[bluez"; then
  IS_BT=1
else
  IS_BT=0
fi

# ICON SET (match your current vibe)
ICON_MUTED=" "
ICON_LOW=" "
ICON_MID="󰪡 "
ICON_HIGH="󰪤 "
ICON_MAX=" "      # 100% wired
ICON_BT="󰋋 "       # bluetooth normal
ICON_BT_MUTED="󰟎 "
ICON_BT_MAX=" "

# Decide icon
if [[ "$muted" == "[MUTED]" ]]; then
  icon=$([ "$IS_BT" -eq 1 ] && echo "$ICON_BT_MUTED" || echo "$ICON_MUTED")
elif [ "$vol" -ge 100 ]; then
  icon=$([ "$IS_BT" -eq 1 ] && echo "$ICON_BT_MAX" || echo "$ICON_MAX")
elif [ "$vol" -ge 66 ]; then
  icon=$([ "$IS_BT" -eq 1 ] && echo "$ICON_BT" || echo "$ICON_HIGH")
elif [ "$vol" -ge 33 ]; then
  icon=$([ "$IS_BT" -eq 1 ] && echo "$ICON_BT" || echo "$ICON_MID")
elif [ "$vol" -gt 0 ]; then
  icon=$([ "$IS_BT" -eq 1 ] && echo "$ICON_BT" || echo "$ICON_LOW")
else
  icon=$ICON_MUTED
fi

# Output logic
if [[ "$muted" == "[MUTED]" ]]; then
  echo "{\"text\":\" $icon\",\"class\":\"muted\"}"

elif [ "$vol" -ge 100 ]; then
  echo "{\"text\":\" $icon\"}"

else
  echo "{\"text\":\" $icon\n$vol\"}"
fi
