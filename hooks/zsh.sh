#!/bin/sh

chsh -s $(which zsh)

KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

idempotent_clone() {
    local url="$1"
    local dir="$2"

    if [ -d "$dir/.git" ]; then
        git -C "$dir" pull --ff-only || return 1
    fi

    if [ -e "$dir" ]; then
        return 0
    fi

    git clone "$url" "$dir" || return 1
}

idempotent_clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
idempotent_clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
idempotent_clone https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoswitch_virtualenv
idempotent_clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
