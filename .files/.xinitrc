xmodmap ~/.Xmodmap
. ~/.profile
xrdb ~/.Xresources
slstatus >/dev/null 2>&1 &
xrandr --output DP-1 --primary --right-of  HDMI-1 --auto
exec dwm
