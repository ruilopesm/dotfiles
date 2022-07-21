# Shell configuration
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="vim"

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
export PATH=$HOME/.config/rofi/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$HOME/.spicetify"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
