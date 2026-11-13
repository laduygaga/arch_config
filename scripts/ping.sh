#!/bin/sh

HOST=1.1.1.1

if ! ping=$(ping -4 -n -c 1 -W 1 $HOST 2>/dev/null); then
    echo "no internet"
else
    rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')
    if [ -z "$rtt" ]; then
        echo ""
    else
        echo "${rtt}ms"
    fi
fi
