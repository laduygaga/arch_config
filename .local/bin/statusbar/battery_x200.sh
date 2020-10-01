_status=$(cat /sys/class/power_supply/BAT0/status)
energy_now=$(cat /sys/class/power_supply/BAT0/energy_now)
energy_full_design=$(cat /sys/class/power_supply/BAT0/energy_full_design)
state=$(awk "BEGIN {printf \"%.2f\",${energy_now}*100/${energy_full_design}}")
printf "%s:%s%s%% " "$_status" "$state"
