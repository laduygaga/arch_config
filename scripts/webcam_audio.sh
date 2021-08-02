yes | ffmpeg -s 640x480 -i /dev/video0 -f pulse -i 0 -c:v libx264 -preset ultrafast -c:a aac ~/.trash/"`date "+%Y%b%d(%a)%I:%M%p"`_webcam_audio.mp4" > /dev/null 2>&1
