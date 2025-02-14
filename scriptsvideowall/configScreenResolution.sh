
# Create new resolution
modeline=$(cvt 400 400 75 | tail -n1 | sed "s/Modeline //")
# Get current screens devices
xrandr -d :0 | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/"