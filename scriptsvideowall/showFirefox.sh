declare -a monitors=( 11 12 13 14 21 22 23 24 31 32 33 34 )
declare -a rows=( 0 0 0 0 1 1 1 1 2 2 2 2 )
declare -a columns=( 0 1 2 3 0 1 2 3 0 1 2 3 )

for ((i=0;i<12;i++))
do
    ssh "admin@192.168.1.${monitors[$i]}" "export DISPLAY=:0; firefox --kiosk http://192.168.1.94?row=${rows[$i]}\&col=${columns[$i]}" &

done
