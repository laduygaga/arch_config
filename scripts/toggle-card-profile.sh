#!/bin/bash
index=`pacmd list-cards  | grep index | tail -1 | awk -F ' ' '{print $2}'`
[[ `pactl list | grep -C2 A2DP | grep 'Active Profile: a2dp_sink_sbc'` ]] && pacmd set-card-profile $index headset_head_unit ||  pacmd set-card-profile $index a2dp_sink_sbc
