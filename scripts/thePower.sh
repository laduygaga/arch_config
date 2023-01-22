#!/bin/bash
# file =$(locate $HOME | dmenu -i -l 10)

[[ ! -z `command -v fd` ]] &&  file=$(fd | dmenu -i -l 10) # fd -HI if want to search hidden file

[[ ! -z $file ]] &&
case $(file --mime-type "$file" -b) in
	text/html) $BROWSER "$file" >/dev/null 2>&1 &;;
	text/*) sh -c "alacritty -e nvim "$file"";;
	audio/*) mpv "$file" >/dev/null 2>&1 &;;
	video/*) mpv "$file" >/dev/null 2>&1 &;;
	image/gif) mpv --loop=inf "$file";;
	image/*) sxiv -b "$file";;
	application/pdf) zathura "$file" >/dev/null 2>&1 ;;
	application/epub+zip) FBReader "$file" >/dev/null 2>&1 &;;
	application/vnd.openxmlformats-officedocument.wordprocessingml.document) wps "$file";;
	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet) libreoffice "$file";;
esac
