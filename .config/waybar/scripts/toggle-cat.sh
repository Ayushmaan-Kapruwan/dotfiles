#!/bin/bash

if pgrep -x "bongocat" >/dev/null;then
  pkill -x "bongocat"
else
  bongocat --config ~/.config/bongocat.conf --watch-config &
fi
