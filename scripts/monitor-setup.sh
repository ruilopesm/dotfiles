#!/bin/sh

case "$(xrandr -q | grep -w connected | wc -l)" in
    1)
	xrandr --output eDP-1 --mode 1920x1080 --rotate normal --refresh 60 --output HDMI-1-0 --off
	;;
    2) 
	xrandr --output eDP-1 --mode 1920x1080 --rotate normal --refresh 60 --output HDMI-1-0 --mode 1920x1080 --rotate normal --refresh 60 --right-of eDP-1
        ;;
esac
