# Shell configuration
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"

ZSH_THEME="candy"

zstyle ':omz:update' mode auto
zstyle ':completion:' use-cache on

ENABLE_CORRECTION="true"

HIST_STAMPS="%d-%m-%Y"

plugins=(git asdf zsh-autosuggestions colored-man-pages command-not-found copypath zsh-interactive-cd z)

# External files
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

# User configuration
export LANG=en_US.UTF-8

# PATH
export PATH=~/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

. /opt/asdf-vm/asdf.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
