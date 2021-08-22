#!/bin/bash

url="0x0.st"
file=$(find $HOME -type f | dmenu -i -l 10)
[[ ! -z $file ]] && curl -sF"file=@$file" $url | xclip -selection c && notify-send "Uploaded!"

