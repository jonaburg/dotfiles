#!/usr/bin/env bash

###############################################################################
# Variables
###############################################################################

ARR=()
ARR+=("")
#wiby"
ARR+=("")
#sel"
ARR+=("🐚")
#ssh
ARR+=("")
#translate
ARR+=("")
#xrescolo
ARR+=("")
#telegram"
ARR+=("")
#youtube
ARR+=("")
#github
rofitheme=(~/.config/rofi/themes/quicklinks.rasi)
menuchoice=$(printf '%s\n' "${ARR[@]}" | rofi -dmenu -config $rofitheme -p ":    ")
rofi_command="rofi -theme ~/.config/rofi/themes/quicklinks.rasi"

# Browser
if [[ -f /sbin/brave ]]; then
	app="brave"
elif [[ -f /usr/bin/firefox ]]; then
	app="firefox"
elif [[ -f /usr/bin/chromium ]]; then
	app="chromium"
elif [[ -f /usr/bin/midori ]]; then
	app="midori"
else
	msg "No suitable web browser found!"
	exit 1
fi


case "$menuchoice" in
	"")
		wiby.sh
		exit 0 ;;
	"")
		rofi -show run -config ~/.config/rofi/themes/default.rasi
		exit 0 ;;
	"🐚")
		rofi -show ssh -config ~/.config/rofi/themes/ssh.rasi
		exit 0 ;;
	"")
		translate
		exit 0 ;;
	"")
		xrescolo
		exit 0 ;;
	"")
		telegram-desktop
		exit 0 ;;
	"")
		$app https://youtube.com
		exit 0 ;;
	"")
		$app https://github.com
		exit 0;;
	esac
done
