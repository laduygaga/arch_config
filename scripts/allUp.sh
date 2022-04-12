#!/bin/bash

url="0x0.st"
file=$(find $HOME \
	-not -path '/home/duy/.local*'\
	-not -path '/home/duy/.oh-my-zsh*'\
	-not -path '/home/duy/.cache*'\
	-not -path '*/__pycache__*'\
	-not -path '*/.git/*'\
	-type f | dmenu -i -l 10)

[[ ! -z $file ]] && curl -sF"file=@$file" $url | xclip -selection c && notify-send "Uploaded!"

