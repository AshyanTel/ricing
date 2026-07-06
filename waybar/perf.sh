#!/bin/sh

state_file="${XDG_RUNTIME_DIR:-/tmp}/waybar-perf.stat"

read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
cpu_total=$((user + nice + system + idle + iowait + irq + softirq + steal))
cpu_idle=$((idle + iowait))

if [ -f "$state_file" ]; then
    read -r prev_total prev_idle < "$state_file"
    total_diff=$((cpu_total - prev_total))
    idle_diff=$((cpu_idle - prev_idle))

    if [ "$total_diff" -gt 0 ]; then
        cpu_usage=$(((100 * (total_diff - idle_diff)) / total_diff))
    else
        cpu_usage=0
    fi
else
    cpu_usage=0
fi

printf '%s %s\n' "$cpu_total" "$cpu_idle" > "$state_file"

mem_usage=$(free | awk '/Mem:/ {printf "%d", ($3 / $2) * 100}')
swap_usage=$(free | awk '/Swap:/ {if ($2 > 0) printf "%d", ($3 / $2) * 100; else print 0}')

printf '{"text":" %s%%  %s%%","tooltip":"CPU: %s%%\\nRAM: %s%%\\nSwap: %s%%"}\n' \
    "$cpu_usage" "$mem_usage" "$cpu_usage" "$mem_usage" "$swap_usage"
