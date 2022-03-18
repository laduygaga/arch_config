#!/bin/bash
# for pulseaudio
# index=`pacmd list-cards  | grep index | tail -1 | awk -F ' ' '{print $2}'`
# [[ `pactl list | grep -C2 A2DP | grep 'Active Profile: a2dp_sink_sbc'` ]] && pacmd set-card-profile $index headset_head_unit ||  pacmd set-card-profile $index a2dp_sink_sbc


# for pipewire
# list sink|output devices
switch_sink() {
	list_sink=`pactl list sinks | grep "Name:" | awk -F ' ' '{print $2}'`
	a=`echo $list_sink | awk -F ' ' '{print $1}'`
	b=`echo $list_sink | awk -F ' ' '{print $2}'`
	# switch ouput|sink
	pactl info | grep `echo $a` && pactl set-default-sink `echo $b` || pactl set-default-sink `echo $a`
}
toggle_jbl_go_mic() {
	jbl_source='bluez_input.E8_D0_3C_FE_28_4E.headset-head-unit'
	default_source='alsa_input.pci-0000_00_1f.3.analog-stereo'
	# switch ouput|sink
	pactl info | grep `echo $jbl_source` && pactl set-card-profile  bluez_card.E8_D0_3C_FE_28_4E  a2dp-sink-sbc_xq && pactl set-default-source `echo $default_source` || pactl set-card-profile  bluez_card.E8_D0_3C_FE_28_4E headset-head-unit-cvsd && pactl set-default-source `echo $jbl_source`
}

# switch_sink
# toggle_jbl_go_mic
$*
