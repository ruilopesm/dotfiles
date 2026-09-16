#!/bin/sh
set -eu

plug_file="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
system_python="/usr/bin/python3"

mkdir -p "$(dirname "$plug_file")"

if [ ! -f "$plug_file" ]; then
  curl -fLo "$plug_file" \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -x "$system_python" ]; then
  echo "$system_python is required for Neovim's Python provider" >&2
  exit 1
fi

if ! "$system_python" -c 'import pynvim' >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm python-pynvim
fi

nvim --headless '+PlugInstall --sync' +qa
