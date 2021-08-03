#!/bin/bash

file=$(find $HOME -type f -not -path '*/\.git/*' -not -path '*/\.vim/*' -not -path '*/\venv/*'| dmenu -i -l 10)

case $(file --mime-type "$file" -b) in
	text/html) $BROWSER "$file" >/dev/null 2>&1 &;;
	text/*) sh -c "alacritty -e vim "$file"";;
	audio/*) mpv "$file" >/dev/null 2>&1 &;;
	video/*) mpv "$file" >/dev/null 2>&1 &;;
	image/gif) mpv --loop=inf "$file";;
	image/*) sxiv -b "$file";;
	application/pdf) zathura "$file" >/dev/null 2>&1 ;;
	application/epub+zip) FBReader "$file" >/dev/null 2>&1 &;;
	application/vnd.openxmlformats-officedocument.wordprocessingml.document) wps "$file";;
	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet) libreoffice "$file";;
esac
