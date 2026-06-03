#!/bin/bash

file=$HOME/.dclip_cache
size=100

if [ "$1" == "copy" ]; then
    # -o outputs the selection, -selection clipboard targets the system clipboard
    sel_clip=$(xclip -selection clipboard -o)
    sel_file=$(echo -n "$sel_clip"|tr '\n' '\034')
fi
touch $file
if [ "$1" == "paste" ]; then
    shift
    sel_file=$(awk '!x[$0]++' $file | dmenu -l 5 ${1+"$@"})
    sel_clip=$(echo -n "$sel_file"|tr '\034' '\n')
fi

if [ "$1" == "clear" ]; then
    echo -n > $file
fi

[ "$sel_clip" == "" ] && exit 1

sed "/^$sel_file$/d" -i $file
cut=$(head -n $(($size-1)) $file)
echo "$sel_file" > $file
echo -n "$cut" >> $file

# -quiet prevents the script from locking up on large payloads
# -selection primary replaces xsel -p
echo -n "$sel_clip" | xclip -quiet -selection primary
# -selection clipboard replaces xsel -b
echo -n "$sel_clip" | xclip -quiet -selection clipboard

exit 0
