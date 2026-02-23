#!/usr/bin/env bash

wal_colors="$HOME/.cache/wal/colors"

# Output theme file
output="$HOME/.config/btop/themes/wal.theme"

# Read 16 colors from pywal
readarray -t colors < "$wal_colors"

cat > "$output" << EOF
# Wal → btop theme generated automatically

theme[main_bg]=""
theme[main_fg]="${colors[6]}"

theme[title]="${colors[5]}"
theme[hi_fg]="${colors[6]}"
theme[selected_bg]="${colors[8]}"
theme[selected_fg]="${colors[5]}"
theme[inactive_fg]="${colors[8]}"
theme[proc_misc]="${colors[6]}"
theme[cpu_box]="${colors[1]}"
theme[mem_box]="${colors[1]}"
theme[net_box]="${colors[1]}"
theme[proc_box]="${colors[1]}"
theme[div_line]="${colors[2]}"

# Temperature graph colors
theme[temp_start]="${colors[1]}"
theme[temp_mid]=""
theme[temp_end]="${colors[6]}"

# CPU graph colors
theme[cpu_start]="${colors[1]}"
theme[cpu_mid]=""
theme[cpu_end]="${colors[6]}"

# Mem/Disk free meter
theme[free_start]="${colors[1]}"
theme[free_mid]=""
theme[free_end]="${colors[6]}"

# Mem/Disk cached meter
theme[cached_start]="${colors[1]}"
theme[cached_mid]=""
theme[cached_end]="${colors[6]}"

# Mem/Disk available meter
theme[available_start]="${colors[1]}"
theme[available_mid]=""
theme[available_end]="${colors[6]}"

# Mem/Disk used meter
theme[used_start]="${colors[1]}"
theme[used_mid]=""
theme[used_end]="${colors[6]}"

# Download graph colors
theme[download_start]="${colors[1]}"
theme[download_mid]=""
theme[download_end]="${colors[6]}"

# Upload graph colors
theme[upload_start]="${colors[1]}"
theme[upload_mid]=""
theme[upload_end]="${colors[6]}"
EOF

