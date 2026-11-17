# Shell
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="custom"

zstyle ':omz:update' mode auto
zstyle ':completion:' use-cache on

plugins=(git zsh-autosuggestions colored-man-pages command-not-found fzf-tab z autoswitch_virtualenv zsh-syntax-highlighting)

export HISTFILESIZE=100000000000
export SAVEHIST=5000000
export HISTSIZE=5000000
HIST_STAMPS="%d-%m-%Y %H:%M:%S"

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

ENABLE_CORRECTION="true"
CORRECT_IGNORE_FILE=tests
CORRECT_IGNORE_FILE=logs

# direnv
eval "$(direnv hook zsh)"

# mise
eval "$(/home/rui/.local/bin/mise activate zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# atuin (after fzf, to take over Ctrl+R)
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"

# uv
eval "$(uv generate-shell-completion zsh)"
