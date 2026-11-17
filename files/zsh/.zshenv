export DOTFILES_DIRECTORY="$HOME/dotfiles"
export LANG=en_US.UTF-8
export EDITOR=/usr/bin/nvim
export SUDO_EDITOR=nvim
export BROWSER=/usr/bin/zen-browser
export ANDROID_HOME="$HOME/Android/Sdk"
export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 4096000"

typeset -U path PATH

# Keep inherited toolchain and virtualenv paths in place in nested shells.
for dotfiles_bin in \
    "$HOME/bin" \
    "$HOME/.local/bin" \
    "$HOME/.local/share" \
    "$DOTFILES_DIRECTORY/files/scripts" \
    "$HOME/.cargo/bin" \
    /usr/local/texlive/2025/bin/x86_64-linux
do
    if (( ${path[(Ie)$dotfiles_bin]} == 0 )); then
        path=("$dotfiles_bin" "${path[@]}")
    fi
done
unset dotfiles_bin

path+=("$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools")
export PATH

typeset -TU MANPATH manpath
manpath=(/usr/local/texlive/2025/texmf-dist/doc/man "${manpath[@]:-}")
typeset -TU INFOPATH infopath
infopath=(/usr/local/texlive/2025/texmf-dist/doc/info "${infopath[@]:-}")
export MANPATH INFOPATH
