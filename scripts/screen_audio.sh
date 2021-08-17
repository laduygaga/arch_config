yes | ffmpeg  -f x11grab -video_size 1600x900 -i :0 -f pulse -i 0 -c:v libx264 -preset ultrafast -c:a aac ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_screen_audio.mp4" 2>/dev/null
