#!/bin/bash

url="0x0.st"
file=$(find $HOME -type f -not -path '*/\.git/*' -not -path '*/\.vim/*' -not -path '*/\venv/*'| dmenu -i -l 10)
curl -sF"file=@$file" $url | xclip -selection c
notify-send "Uploaded!"

