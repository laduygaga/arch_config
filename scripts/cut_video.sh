#!/bin/bash
# cut video from utube
# ffmpeg -i $(youtube-dl -f best --get-url "$_url") -ss $_start -to $_end ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_cut.mp4"
_url="$1"
_start="$2"
_end="$3"
select i in audio video; do if [[ $i == 'audio' ]]; then
	ffmpeg -ss $_start -to $_end -i "$(youtube-dl -f bestaudio/best --get-url $_url)" -c:a libmp3lame ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_cut.mp3"
	break
elif [[ $i == 'video' ]]; then
	ffmpeg -ss $_start -to $_end -i "$(youtube-dl -f best --get-url $_url)" -c:v copy -c:a copy  ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_cut.mp4"
	break
fi; done
