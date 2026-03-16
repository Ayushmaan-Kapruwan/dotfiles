#!/bin/bash

# --- CONFIGURATION ---
STASH_DIR="$HOME/.config/stash"     # Where your config.yml lives
STASH_BIN="/usr/bin/stash"          # Where the stash binary is
ICON_PATH="$HOME/.local/share/icons/stash.png" # Path to your icon
# ---------------------

# 1. Cleanup Function: Kills Stash when the script ends
cleanup() {
    echo "Cleaning up..."
    # Kill the specific stash process we started
    if [ -n "$STASH_PID" ]; then
        kill "$STASH_PID"
    fi
    exit
}
trap cleanup EXIT INT TERM

# 2. Start Stash in Background
echo "Starting Stash..."
cd "$STASH_DIR"
$STASH_BIN &
STASH_PID=$!

# 3. THE FIX: Wait loop until Stash is actually ready
# We try to connect to port 9999. We wait max 30 seconds.
echo "Waiting for Stash to initialize..."
count=0
while ! curl --output /dev/null --silent --head --fail http://localhost:9999; do
    sleep 1
    count=$((count+1))
    if [ $count -ge 30 ]; then
        echo "Stash failed to start in 30 seconds."
        exit 1
    fi
done

echo "Stash is ready!"

# 4. Launch the Viewer
# We use Epiphany for the best "App-like" experience (No address bar).
# But note: The script might close immediately with Zen unless you use --no-remote

chromium --app=http://localhost:9999

# The script waits here until you close the Epiphany window.
# Once closed, it triggers the 'cleanup' function above.
