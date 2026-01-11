#!/bin/bash
#kill and run eww

#Name of your eww window

WINDOW="control_panel"

#check if the window is already open
if eww active-windows | grep -q "^$WINDOW:";
then
	#if open, then close
	eww close "$WINDOW"
	pkill eww
	sleep 0.3
	GTK_THEME=Adwaita-dark eww daemon &
	sleep 0.3
	
else
	#if not open, open
	pkill eww
	sleep 0.1
	GTK_THEME=Adwaita-dark eww daemon &
	sleep 0.3
	eww open "$WINDOW"
fi
