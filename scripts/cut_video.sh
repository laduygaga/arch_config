#!/bin/bash
# cut video from utube
# ffmpeg -i $(youtube-dl -f best --get-url "$_url") -ss $_start -to $_end ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_cut.mp4"

get_url() {
	youtube-dl -f best --get-url "$1"
}
_cut() {
	ffmpeg -i $url -ss "$1" -to "$2" ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_cut.mp4"
}

main() {
	url=$(get_url $1) && _cut $2 $3
}

main $*
