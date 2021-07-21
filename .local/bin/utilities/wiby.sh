#!/usr/bin/bash
###############################################################################
# Title: Wiby Rofi Search
# Author: Jon Burga
# Date: 2020.03.27
# Deps: rofi, jq, curl.
###############################################################################

###############################################################################
# Variables
###############################################################################

ARR=()
ARR+=("Open Random")
ARR+=("Search specific")
theme=(~/.config/rofi/themes/wiby_solid.rasi)
entry_theme=(~/.config/rofi/themes/entry_prompt.rasi)
menu_choice=$(printf '%s\n' "${ARR[@]}" | rofi -dmenu -config $theme -p "Wiby   :    ")
browser=${BROWSER:-brave}


###############################################################################
# Functions
###############################################################################

process_wiby(){
link=$(cat /tmp/wibyout | jq .'[] | .URL + " >>>> " + .Title' | rofi -dmenu -modi blocks -config ~/.config/rofi/themes/wiby_list.rasi -show blocks -p "Query Results:")
url=$(echo $link | awk -F">" {'print $1'} | awk -F'"' {'print $2'})
}

###############################################################################
# Search Random Website, open in browser.
###############################################################################

if [ "$menu_choice" = "Open Random" ]; then
  choiceWord=$($browser "https://wiby.me/surprise/")
fi

###############################################################################
# Search for Specific Website, display list of items
###############################################################################

if [ "$menu_choice" = "Search specific" ]; then
  choiceWord=$(printf "" | rofi -dmenu -config $entry_theme -p "Enter query: ")
  choice=$(curl https://wiby.me/json/?q=$choiceWord > /tmp/wibyout )
  process_wiby
  if [ ! -z "$url" ]; then
    $browser "$url"
  fi
exit 0
fi
