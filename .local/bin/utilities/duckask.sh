#!/usr/bin/bash


browser=${BROWSER:-brave}
#choice=$( rofi -dmenu -config /usr/share/rofi/themes/dmenu2.rasi -p "Search     :     ")
choice=$( rofi -dmenu -config /usr/share/rofi/themes/dmenu2.rasi -p "Search  🦆   :     ")


if [ "$choice" = ""  ]; then
    return
else
    if echo "$choice" | grep "^(http:\/\/|https:\/\/)?[a-zA-Z0-9]+\.[a-zA-Z]+(/)?.*$"; then
        $browser "$choice"
    else
        $browser "https://duckduckgo.com/?q=$choice&t=ffab&atb=v1-1"
    fi
fi
