#!/bin/bash

TEMP=3500

if pgrep -x hyprsunset >/dev/null; then
  pkill -x hyprsunset
else
  hyprsunset -t "$TEMP" &
fi


