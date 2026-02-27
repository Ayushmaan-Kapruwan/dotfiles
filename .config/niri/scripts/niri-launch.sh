#!/bin/bash

#select wallpaper
SELECTED="$HOME/.cache/current_wallpaper"

#set wallpaper

if [ -f "$SELECTED" ]; then
  swww img "$SELECTED" --transition-type none
fi

update_kitty_trans() {
  local transparency="0.9"
  local conf="$HOME/.config/kitty/kitty.conf"
  
  awk -v val="$transparency" '
  /^[[:space:]]*background_opacity[[:space:]]+/ {
      print "background_opacity " val
      next
  }
  { print }
' "$conf" > "$conf.tmp" && mv "$conf.tmp" "$conf"
}

#update_kitty_trans


update_rofi_bg() {
    local alpha="0.9"
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

#update_rofi_bg

update_gtk_bg() {
  local alpha="0.9"
  local gtk_css="$HOME/.config/gtk-3.0/gtk.css"

  awk -v val="alpha(@theme_base_color, $alpha)" '
			BEGIN { in_block = 0}
			/.background, .window\s*{/ { in_block = 1 }
			in_block && /background-color:/ {sub(/background-color:.*;/, "background-color: " val ";") }
			in_block && /}/ { in_block = 0 }
			{ print }
			' "$gtk_css" > "$gtk_css.tmp" && mv "$gtk_css.tmp" "$gtk_css"
  }

#update_gtk_bg

#script for blurred waybar background
update_Waybar_bg() {
	local alpha="1.0"
	local wal_colors="$HOME/.cache/wal/colors.json"
	local waybar_css="$HOME/.config/waybar/style.css"

	#extracting color and turning it into rgba
	local hex=$(jq -r '.special.background' "$wal_colors" | sed 's/#//')
	local r=$((16#${hex:0:2}))
	local g=$((16#${hex:2:2}))
	local b=$((16#${hex:4:2}))
	local rgba="rgba($r, $g, $b ,$alpha)"

	#debugging 
	echo "setting waybar background to $rgba"

		
	#updating background on waybar's style.css
	awk -v rgba="$rgba" '
		BEGIN { in_block = 0}
		/window#waybar\s*{/ { in_block = 1 }
		in_block && /background-color:/ {sub(/background-color:.*;/, "background-color: " rgba ";") }
		in_block && /}/ { in_block = 0 }
		{ print }
		' "$waybar_css" > "$waybar_css.tmp" && mv "$waybar_css.tmp" "$waybar_css"
  }

#update_Waybar_bg

