#!/bin/bash


swaync-client --close-panel 

SELECTED="$1"

if [ -z "$SELECTED" ]; then
	echo "No wallpaper selected"
	exit 1
fi

  #wait for swww transition
  sleep 2

	#To cache the wallpaper 
	ln -sf "$SELECTED" ~/.cache/current_wallpaper


  #for rofi background
  cp ~/.cache/current_wallpaper ~/.config/rofi/current

	#apply Pywal colors
	wal -i "$SELECTED" 

	#Copy the color scheme to different places
	cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css #waybar
  cp ~/.cache/wal/colors-waybar.css ~/.config/swaync/colors-waybar.css  #swaync
  cp ~/.cache/wal/colors-waybar.css ~/.config/swayosd/colors-waybar.css #swayosd
  cp ~/.cache/wal/colors-waybar.css ~/.config/gtk-4.0/colors-gtk.css  #gtk-4
  cp ~/.cache/wal/colors-waybar.css ~/.config/gtk-3.0/colors-gtk.css  #gtk-3
  cp ~/.cache/wal/colors.qml ~/.config/quickshell/Colors.qml  #quickshell

update_rofi_bg() {
    local alpha="0.5"
    local wal_colors="$HOME/.cache/wal/colors.json"
    local rofi_rasi="$HOME/.config/rofi/config.rasi"

    # background-blur color from special.background
    local bg_hex=$(jq -r '.special.background' "$wal_colors" | sed 's/#//')
    local bgr=$((16#${bg_hex:0:2}))
    local bgg=$((16#${bg_hex:2:2}))
    local bgb=$((16#${bg_hex:4:2}))
    local rgba_bg="rgba($bgr, $bgg, $bgb, $alpha)"

    # foreground color from colors.color6
    local fg_hex=$(jq -r '.colors.color6' "$wal_colors" | sed 's/#//')
    local fgr=$((16#${fg_hex:0:2}))
    local fgg=$((16#${fg_hex:2:2}))
    local fgb=$((16#${fg_hex:4:2}))
    local rgba_fg="rgba($fgr, $fgg, $fgb, 1.0)"

    # text-color from special.foreground
    local tc_hex=$(jq -r '.special.foreground' "$wal_colors" | sed 's/#//')
    local tcr=$((16#${tc_hex:0:2}))
    local tcg=$((16#${tc_hex:2:2}))
    local tcb=$((16#${tc_hex:4:2}))
    local rgba_tc="rgba($tcr, $tcg, $tcb, 1.0)"

    #selected = foreground with alpha 0.5
    local rgba_sel="rgba($fgr, $fgg, $fgb, 0.5)"

    echo "Updating rofi:"
    echo " - background-blur → $rgba_bg"
    echo " - foreground → $rgba_fg"
    echo " - text-color → $rgba_tc"
    echo " - selected → $rgba_sel"

    awk -v rgba_bg="$rgba_bg" -v rgba_fg="$rgba_fg" -v rgba_tc="$rgba_tc" -v rgba_sel="$rgba_sel" '
        BEGIN { in_star=0; have_bg=0; have_fg=0; have_tc=0; have_sel=0 }
        /^[[:space:]]*\*[[:space:]]*\{/ { in_star=1 }
        in_star && /background-blur[[:space:]]*:/ { sub(/background-blur[[:space:]]*:[^;]*;/, "background-blur: " rgba_bg ";"); have_bg=1 }
        in_star && /foreground[[:space:]]*:/     { sub(/foreground[[:space:]]*:[^;]*;/, "foreground: " rgba_fg ";"); have_fg=1 }
        in_star && /text-color[[:space:]]*:/     { sub(/text-color[[:space:]]*:[^;]*;/, "text-color: " rgba_tc ";"); have_tc=1 }
        in_star && /selected[[:space:]]*:/       { sub(/selected[[:space:]]*:[^;]*;/, "selected: " rgba_sel ";"); have_sel=1 }
        in_star && /^\}/ {
            if (!have_bg) print "    background-blur: " rgba_bg ";"
            if (!have_fg) print "    foreground: " rgba_fg ";"
            if (!have_tc) print "    text-color: " rgba_tc ";"
            if (!have_sel) print "    selected: " rgba_sel ";"
            in_star=0
        }
        { print }
    ' "$rofi_rasi" > "$rofi_rasi.tmp" && mv "$rofi_rasi.tmp" "$rofi_rasi"
}
  
  bash ~/.config/hypr/scripts/mouse.sh
  #run rofi color function
  update_rofi_bg
	
	#update_Waybar_bg
	#killall waybar && waybar &
  #killall qs && qs &
  
  #swaync
  swaync-client --reload-css

  #swayosd
  killall swayosd-server && swayosd-server &

	#Reload kitty with new colors
	kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf

  bash ~/.config/hypr/scripts/btop-colors.sh
	hyprctl reload


