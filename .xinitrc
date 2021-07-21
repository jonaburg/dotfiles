#!/usr/bin/env sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

exec awesome
	#exec i3

killall sxhkd
exec sxhkd &
