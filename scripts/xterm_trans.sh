# xterm -hold  -geometry 50x20+0+590 -e trans :vi -b "`xclip -o`"

# Improved version to handle long text better
xterm -T "xterm_trans.sh" -geometry 50x20+0+590 -e bash -c "xclip -o | trans :vi -b | fmt -w 50; echo ''; read -n 1 -s -p 'Press any key to close...'"
