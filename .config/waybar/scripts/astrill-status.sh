#!/bin/bash

echo "[astrill-status] Running at $(date)">> /tmp/astrill_debug.log
pgrep -fl astrill >> /tmp/astrill_debug.log

# Astrill VPN Status Script for Waybar
# Place this at ~/.config/waybar/scripts/astrill-status.sh

CONFIG_DIR="$HOME/.config/astrill"
INI_FILE="$CONFIG_DIR/Astrill.ini"
#LOG_FILE="$CONFIG_DIR/astrill.log"

# Function to check if Astrill process is running
check_astrill_process() {
    #if pgrep -x "astrill" > /dev/null; then
    ps -eo comm | grep -iq astrill
    return $?
        #return 0
    #else
     #   return 1
    #fi
}

# Function to get connection status
get_connection_status() {
    # First check if Astrill process is running
    if ! check_astrill_process; then
        echo "Offline"
        return 1
    fi
    
    # Check Astrill.ini for current server/status
    if [ -f "$INI_FILE" ]; then
        # Look for current server in ini file
        CURRENT_SERVER=$(grep -iE "current.*server|last.*server\selected.*server" "$INI_FILE" | head -1 | cut -d'=' -f2 | tr -d ' "' | sed 's/.*\///g' | sed 's/\..*//g')
        
        # Look for connection status
        CONNECTED=$(grep -iE "connected|status" "$INI_FILE" | grep -iE "true|connected\|1" | head -1)
        
        if [ -n "$CONNECTED" ] && [ -n "$CURRENT_SERVER" ]; then
            # Extract country name from server (common format: country-city-number)
            COUNTRY=$(echo "$CURRENT_SERVER" | sed 's/-.*//g' | sed 's/[0-9]*//g')
            if [ -n "$COUNTRY" ]; then
                # Capitalize first letter
                COUNTRY=$(echo "$COUNTRY" | sed 's/\b\w/\U&/g')
                echo "$COUNTRY"
                return 0
            fi
        fi
    fi
    
    # Check log file if ini doesn't have clear info
   # if [ -f "$LOG_FILE" ]; then
        # Look for recent connection messages
    #    if grep -q "Connected\|connected" "$LOG_FILE" 2>/dev/null; then
     #       SERVER=$(grep "Connected\|connected" "$LOG_FILE" | tail -1 | grep -o '[A-Z][a-z]*' | head -1)
      #      if [ -n "$SERVER" ]; then
       #         echo "$SERVER"
        #        return 0
         #   fi
       # fi
   # fi
    
    # If process is running but no clear connection info
    echo "Ready"
    return 0
}

# Main execution
get_connection_status || echo "Status Unknown"


# Output for Waybar
#case "$STATUS" in
 #   "Disconnected")
  #      echo "Offline"
   #     ;;
   # "Running")
    #    echo "Ready"
     #   ;;
    #"Connected")
     #   echo "Online"
      #  ;;
   # *)
        # If we got a specific server/country name
    #    echo "$STATUS"
     #   ;;
#esac
