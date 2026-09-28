#!/bin/sh
count=$(makoctl history -j | jq 'length')

i=0
while [ "$i" -lt "$count" ]; do
    makoctl restore
    makoctl dismiss --no-history
    i=$((i + 1))
done

pkill -RTMIN+8 waybar
