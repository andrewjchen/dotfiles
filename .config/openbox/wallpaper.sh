#!/bin/sh
while true;
do
   find $HOME/.wallpaper -type f -name '*.jpg' -o -name '*.png' | shuf -n 1 | xargs feh --bg-scale
   sleep 5m
done &