# Shell configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="candy"

zstyle ':omz:update' mode auto
zstyle ':completion:' use-cache on

ENABLE_CORRECTION="true"

# History
export HISTFILESIZE=100000000000
export SAVEHIST=5000000
export HISTSIZE=5000000
HIST_STAMPS="%d-%m-%Y"

plugins=(git asdf zsh-autosuggestions colored-man-pages command-not-found fzf-tab z zsh-syntax-highlighting autoswitch_virtualenv)

# External files
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

# User configuration
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR=/usr/bin/nvim
export SUDO_EDITOR=nvim
export BROWSER=/usr/bin/firefox-developer-edition
export TERM=alacritty
CORRECT_IGNORE_FILE=tests

# PATH
export PATH=~/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share:$PATH
export PATH=$HOME/dotfiles/scripts:$PATH

# asdf
ASDF_DIRENV_IGNORE_MISSING_PLUGINS=1
ASDF_DATA_DIR="/home/rui/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# flyctl
export FLYCTL_INSTALL="/home/rui/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# go
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export GOPATH=$HOME/.go
export PATH="$PATH:/usr/bin/go:$PATH"

# elixir
export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 4096000"

# vcpkg
export VCPKG_ROOT=$HOME/Clones/vcpkg
export PATH=$HOME/Clones/vcpkg:$PATH

# pnpm
export PNPM_HOME="/home/rui/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# direnv
eval "$(direnv hook zsh)"

# bun
[ -s "/home/rui/.bun/_bun" ] && source "/home/rui/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# rust
. "$HOME/.cargo/env"

# clipcat
if type clipcat-menu >/dev/null 2>&1; then
    alias clipedit='clipcat-menu --finder=builtin edit'
    alias clipdel='clipcat-menu --finder=builtin remove'

    bindkey -s '^\' "^Q clipcat-menu --finder=builtin insert ^J"
    bindkey -s '^]' "^Q clipcat-menu --finder=builtin remove ^J"
fi
