#!/bin/bash
[[ `pactl list | grep -C2 A2DP | grep 'Active Profile: a2dp_sink_sbc'` ]] && pacmd set-card-profile 1 headset_head_unit ||  pacmd set-card-profile 1 a2dp_sink_sbc
