#!/bin/bash

file=$HOME/.dclip_cache
size=100

# 1. Handle Copy
if [ "$1" == "copy" ]; then
    sel_clip=$(xclip -selection clipboard -o)
    sel_file=$(echo -n "$sel_clip" | tr '\n' '\034')
fi

touch "$file"

# 2. Handle Paste
if [ "$1" == "paste" ]; then
    shift
    sel_file=$(awk '!x[$0]++' "$file" | dmenu -l 5 ${1+"$@"})
    sel_clip=$(echo -n "$sel_file" | tr '\034' '\n')
    
    # CRITICAL FIX: Update the system clipboard IMMEDIATELY 
    # so the active window receives the new data without delay.
    [ -n "$sel_clip" ] && echo -n "$sel_clip" | xclip -quiet -selection clipboard
    [ -n "$sel_clip" ] && echo -n "$sel_clip" | xclip -quiet -selection primary
fi

# 3. Handle Clear
if [ "$1" == "clear" ]; then
    echo -n > "$file"
fi

# Exit if nothing was captured/selected
[ -z "$sel_clip" ] && exit 1

# 4. Background File Housekeeping
# This can run slightly slower without blocking the clipboard update
sed "/^$sel_file$/d" -i "$file"
cut=$(head -n $(($size-1)) "$file")
echo "$sel_file" > "$file"
echo -n "$cut" >> "$file"

exit 0
