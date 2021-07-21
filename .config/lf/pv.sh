#!/usr/bin/env bash

# preview script

FILE="${1}"
HEIGHT="${2}"

[ -L "${FILE}" ] && FILE="$(readlink "${FILE}")"

# show file title
echo -e "\e[33m# \e[34m$(basename "${FILE}")\e[0m"

case "$(file -b --mime-type "${FILE}")" in
	# image terminal view with chafa/timg/catimg/cam/imgcat
	image/*)
		chafa --fill=space -c 256 -s 80x"${HEIGHT}" "${FILE}" || \
			timg "${FILE}" || \
			catimg -r 2 -w 110 -t "${FILE}" || \
			cam -H "$(echo "$HEIGHT*0.6/1" | bc)" "${FILE}" || \
			imgcat --depth=256 --height "$(echo "$HEIGHT*0.9/1" | bc)" "${FILE}"
		echo
		exif "${FILE}"
		exit 0
		;;
esac
