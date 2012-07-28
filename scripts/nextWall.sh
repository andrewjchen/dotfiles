#!/bin/sh
find $HOME/.wallpaper/cycle -type f -name '*.jpg' -o -name '*.png' | shuf -n 1 | xargs feh --bg-scale

