yes | ffmpeg -f x11grab -video_size 1366x768 -i :0 -c:v libx264 -preset ultrafast ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_screen_only.mp4" 2> /dev/null
