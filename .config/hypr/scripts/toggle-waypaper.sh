#!/bin/bash

#Get the window ID of running waypaper instance
if pgrep -x waypaper > /dev/null; then
  #waypaper is already running so kill it
  pkill waypaper
else
  #open waypaper 
  waypaper &
fi
