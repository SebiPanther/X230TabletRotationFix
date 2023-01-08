#!/bin/bash
echo "X230FRotateFix - Fixing Wacom rotation on Lenovo Thinkpad X230 Tablet"
displayName="LVDS-1"
wacomDevices=("Wacom ISDv4 E6 Pen stylus" "Wacom ISDv4 E6 Pen eraser" "Wacom ISDv4 E6 Finger touch")

xrandrOutput=$(xrandr | grep "${displayName}")

echo "Display Informations for ${displayName}: ${xrandrOutput}"
orientation=none
if [[ "$xrandrOutput" == *" left ("* ]]; then
	orientation=ccw
fi
if [[ "$xrandrOutput" == *" right ("* ]]; then
        orientation=cw
fi
if [[ "$xrandrOutput" == *" inverted ("* ]]; then
        orientation=half
fi
echo "New orientation: ${orientation}"

for ((i = 0; i < ${#wacomDevices[@]}; i++))
do
	wacomDevice="${wacomDevices[$i]}"
	echo "Fixing ${wacomDevice}..."
	xsetwacom --set "${wacomDevice}" MapToOutput "${displayName}"
	xsetwacom --set "${wacomDevice}" Rotate $orientation
done
echo "Done."
