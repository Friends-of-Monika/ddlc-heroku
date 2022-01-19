#!/bin/sh
export DISPLAY=:0
Xvfb -screen 0 "$GEOMETRY" & fluxbox &

eval $COMMANDLINE &

/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen "0.0.0.0:$PORT" &
x11vnc -nopw -forever
