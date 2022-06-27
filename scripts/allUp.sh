#!/bin/bash

url="0x0.st"

[[ ! -z `command -v fd` ]]  && file=$(fd -HI | dmenu -i -l 10)

[[ ! -z $file ]] && curl -sF"file=@$file" $url | xclip -selection c && notify-send "Uploaded!"

