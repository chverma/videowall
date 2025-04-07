#!/bin/bash

# Configuración
STREAM="rtp://239.255.1.1:5004"
RES_X=1280
RES_Y=720
COLS=4
ROWS=3
SSH_USER="admin"
VLC_CMD="vlc"
# Configuración de hardware decoding (elige una)
HW_ACCEL="--avcodec-hw=vaapi"  # Para Intel/AMD
# HW_ACCEL="--avcodec-hw=vdpau"  # Para NVIDIA
# HW_ACCEL="--avcodec-hw=none"   # Sin aceleración
PASSWORD="admin"

# Main
SEGMENT_WIDTH=$((RES_X / COLS))
SEGMENT_HEIGHT=$((RES_Y / ROWS))

declare -a ADDRESSES=(
    "192.168.1.11" "192.168.1.12" "192.168.1.13" "192.168.1.14"
    "192.168.1.21" "192.168.1.22" "192.168.1.23" "192.168.1.24"
    "192.168.1.31" "192.168.1.32" "192.168.1.33" "192.168.1.34"
)

start_stream() {
    local i=0
    for row in {0..2}; do
        for col in {0..3}; do
            X_POS=$(( (col+1) * SEGMENT_WIDTH ))
            Y_POS=$(( (row+1) * SEGMENT_HEIGHT))
            
            CROP_LEFT=$(( $X_POS - SEGMENT_WIDTH ))
            CROP_RIGHT=$((RES_X - X_POS)) #$((RES_X - X_POS - SEGMENT_WIDTH))
            CROP_TOP=$(( $Y_POS - SEGMENT_HEIGHT ))
            CROP_BOTTOM=$((RES_Y - Y_POS))

            ssh $SSH_USER@${ADDRESSES[$i]} "\
                DISPLAY=:0 \
                $VLC_CMD '$STREAM' \
		--aspect-ratio=5:4 \
                --video-filter=croppadd \
		--croppadd-croptop=$CROP_TOP --croppadd-cropbottom=$CROP_BOTTOM --croppadd-cropleft=$CROP_LEFT --croppadd-cropright=$CROP_RIGHT \
                --no-video-title-show \
                -f" &
            vlc.exe video_480x360.mp4 --video-filter=croppadd --croppadd-croptop=10 --croppadd-cropbottom=140 --croppadd-cropleft=10 --croppadd-cropright=160


            i=$((i + 1))
        done
    done
}

stop_stream() {
    for ip in "${ADDRESSES[@]}"; do
        ssh $SSH_USER@"$ip" "killall -9 $VLC_CMD" &
    done
}

poweroff_v() {
    for ip in "${ADDRESSES[@]}"; do
        ssh $SSH_USER@"$ip" "echo $PASSWORD | sudo -S shutdown -h now" &
    done
}



case "$1" in
    1|start)
        start_stream
        ;;
    0|stop)
        stop_stream
        ;;
    2|poweroff)
        poweroff_v
        ;;
    *)
        echo "Uso: $0 [stop|0|start|1|poweroff|1]"
        exit 1
        ;;
esac
