xmodmap ~/.Xmodmap
. ~/.profile
xrdb ~/.Xresources
slstatus >/dev/null 2>&1 &
# xrandr --setprovideroutputsource Intel
# xrandr --output DP2 --mode 1920x1080 --rate 165
exec dwm
