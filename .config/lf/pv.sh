#!/bin/sh

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
	*.png|*.jpg) exiftool "$1" && exit 5; exit 1;;
	*.mkv|*.mp4|*.mp3|*.flac|*.webm) mediainfo "$1" && exit 5; exit 1;;
    *) highlight -O ansi "$1" || cat "$1";;
esac
