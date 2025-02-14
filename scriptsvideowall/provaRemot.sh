#!/bin/bash

export DISPLAY=:0

#fil="1"
#col="2"

hostname=$(hostname)

case $hostname in
	PC1)
		fil=0
		col=0
		;;
	PC2)
		fil=0
		col=2
		;;
	PC3)
		fil=1
		col=0
		;;
	PC4)
		fil=1
		col=2
		;;
	PC5)
		fil=2
		col=0
		;;
	PC6)
		fil=2
		col=2
		;;
esac

# Opens firefox on the left monitor
firefox -private "http://10.0.0.10/tile.php?row=$fil&col=$col" &
sleep 1
# Moves firefox to the left
xdotool getactivewindow windowmove 300 300
sleep 1
#xdotool key alt+F7
sleep 1
#xdotool getactivewindow windowmove 300 300
sleep 1
# Runs firefox on fullscreen
xdotool key F11
#unclutter -idle 0 &

sleep 1

#export DISPLAY=:1.0
# Opens firefox on the right monitor
col=$[$col+1]
firefox -new-window "http://10.0.0.10/tile.php?row=$fil&col=$col" &
sleep 1

# Moves firefox to the right
xdotool getactivewindow windowmove 1450 300
sleep 1
#xdotool key alt+F7   
sleep 1
#xdotool getactivewindow windowmove 1450 300
sleep 1
# Runs firefox on fullscreen
xdotool key F11


#sleep 1
#xdotool mousemove 300 300
#unclutter -idle 0 



#xdotool getactivewindow windowmove 0 1450
#xdotool key alt+space
#xdotool key 0xff54
#xdotool key 0xff54
#xdotool key 0xff54
#xdotool key 0xff54
#xdotool key 0xff0d
#xdotool getactivewindow windowmove 1450 300
#xdotool click 1
#xdotool key F11
