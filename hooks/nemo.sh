#!/bin/sh

gsettings set org.cinnamon.desktop.default-applications.terminal exec 'alacritty'

xdg-mime default code.desktop text/plain
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop text/x-shellscript

mkdir -p ~/.local/share/nemo/actions
cp files/nemo/*.nemo_action ~/.local/share/nemo/actions/
