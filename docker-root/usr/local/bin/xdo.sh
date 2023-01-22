#!/bin/bash

export DISPLAY=:1

xdotool mousemove --window 8388609 652 488 click 1

xdotool mousemove --window 8388609 231 309 click 1 type "${LOGIN_URL}"
xdotool key Return
sleep 6
echo "entering login page"

# xdotool key Tab
xdotool mousemove --window 8388609 501 268 click --repeat 5 1 type "${EC_USER}"
sleep 0.3

xdotool key Tab
sleep 0.3

xdotool mousemove --window 8388609 501 325 click --repeat 2 1 type "${EC_PASSWORD}"
sleep 0.3

xdotool key Return

sleep 2
echo "entering TOP code"

function remove_code {
    xdotool mousemove --window 8388609 463 328 click 1
    for i in `seq 1 16`; do
        xdotool key BackSpace
    done
}

for i in `seq 1 10`; do
    remove_code
    xdotool type "${AUTH}" && xdotool key Return
    sleep 0.4
done

echo "the auto input is done; take a try!!!"