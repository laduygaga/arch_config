if [[ -z "$INTERFACE" ]] ; then
    INTERFACE="${BLOCK_INSTANCE:-wlp3s0}"
fi
#------------------------------------------------------------------------

# As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
# connection (think desktop), the corresponding block should not be displayed.
# Similarly, if the wifi interface exists but no connection is active, show
# nothing
[[ ! -d /sys/class/net/"${INTERFACE}"/wireless || \
    "$(cat /sys/class/net/"$INTERFACE"/operstate)" = 'down' ]] && exit

#------------------------------------------------------------------------

SSID=$(iw "$INTERFACE" info | awk '/ssid/ {print $2}')

#------------------------------------------------------------------------

echo "$SSID" # full text
echo "$SSID" # short text
echo "#00FF00" # color
