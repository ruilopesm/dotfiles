#!/bin/sh

sudo rm /etc/fonts/conf.d/50-user.conf
sudo cp ../files/misc/50-noto-color-emoji.conf /etc/fonts/conf.d/
fc-cache --really-force
