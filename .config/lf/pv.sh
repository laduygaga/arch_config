#!/bin/sh

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
	*.png|*.jpg) exiftool "$1" ;;
	*.mkv|*.mp4|*.mp3|*.flac|*.webm|*.m4v) mediainfo "$1" ;;
	*.html) lynx -dump $1 ;;
	*.json) cat "$1" | jq ;;
    *) highlight -O ansi "$1" || cat "$1";;
esac
