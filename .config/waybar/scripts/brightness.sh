#!/bin/bash

#get current brightness value 
brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( 100 * brightness / max))
echo "$percent"


