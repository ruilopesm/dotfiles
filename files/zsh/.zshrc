# Shell
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="candy"

zstyle ':omz:update' mode auto
zstyle ':completion:' use-cache on

plugins=(git zsh-autosuggestions colored-man-pages command-not-found fzf-tab z autoswitch_virtualenv zsh-syntax-highlighting)

export HISTFILESIZE=100000000000
export SAVEHIST=5000000
export HISTSIZE=5000000
HIST_STAMPS="%d-%m-%Y"

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

# User
export LANG=en_US.UTF-8
export EDITOR=/usr/bin/nvim
export SUDO_EDITOR=nvim
export BROWSER=/usr/bin/firefox-developer-edition
export TERM=alacritty

ENABLE_CORRECTION="true"
CORRECT_IGNORE_FILE=tests
CORRECT_IGNORE_FILE=logs

export PATH=~/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share:$PATH
export PATH=$DOTFILES_DIRECTORY/files/scripts:$PATH

# direnv
eval "$(direnv hook zsh)"

# mise
eval "$(/home/rui/.local/bin/mise activate zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# elixir
export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 4096000"

# uv
eval "$(uv generate-shell-completion zsh)"

# texlive
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:${MANPATH:-}"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:${INFOPATH:-}"
