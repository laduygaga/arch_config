yes | ffmpeg -f x11grab -video_size 1600x900 -i :0  -f pulse -i default -c:v libx264 -preset ultrafast -c:a aac ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_screen_mic.mp4" 2>/dev/null
