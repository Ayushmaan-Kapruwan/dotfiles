#!/bin/bash

#1. CHeck if astrill is running 
if ! ps -eo comm | grep -iq astrill; then 
	echo "Offline"
	exit 0
fi 

#2. get current external ip
VPN_IP=$(curl -s --max-time 2 https://ipinfo.io/ip)

#3. GEt ISP name or country 
VPN_COUNTRY=$(curl -s --max-time 2 https://ipinfo.io/country)

if [ -n "$VPN_COUNTRY" ]; then 
	echo "$VPN_COUNTRY"
else
	echo "Online" 
fi

