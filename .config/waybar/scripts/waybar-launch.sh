#!/bin/bash
#
# _    _             _                  _                            _      
#| |  | |           | |                | |                          | |     
#| |  | | __ _ _   _| |__   __ _ _ __  | |     __ _ _   _ _ __   ___| |__   
#| |/\| |/ _` | | | | '_ \ / _` | '__| | |    / _` | | | | '_ \ / __| '_ \  
# \  /\  / (_| | |_| | |_) | (_| | |    | |___| (_| | |_| | | | | (__| | | | 
# \/  \/ \__,_|\__, |_.__/ \__,_|_|    \_____/\__,_|\__,_|_| |_|\___|_| |_| 
#               __/ |                                                       
#              |___/                                                        
#
#
#wait to ensure hypland is fully ready
sleep 2
#Quit running waybar instatnces 
killall waybar

#loading waybar based on profile
if [[ $USER = "vessel" ]]
then
	waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &
else
	waybar &
fi


