# Shell configuration
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"

ZSH_THEME="candy"

zstyle ':omz:update' mode auto
zstyle ':completion:' use-cache on

ENABLE_CORRECTION="true"

# History
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
HIST_STAMPS="%d-%m-%Y"

plugins=(git asdf zsh-autosuggestions colored-man-pages command-not-found copypath zsh-interactive-cd z)

# External files
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

# User configuration
export LANG=en_US.UTF-8
export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/firefox-developer-edition
export TERM=alacritty
CORRECT_IGNORE_FILE=tests

# PATH
export PATH=~/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share:$PATH
export PATH=$HOME/dotfiles/scripts:$PATH

. /opt/asdf-vm/asdf.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/home/rui/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
