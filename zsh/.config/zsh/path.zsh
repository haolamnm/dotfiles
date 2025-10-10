#!/bin/zsh


### HELPER FUNCTIONS
path_prepend() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}
path_append() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}


### USER LOCAL
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"


### DEVELOPMENT TOOLS
path_append "$XDG_DATA_HOME/cargo/bin"
path_append "/var/lib/flatpak/exports/bin"


fpath=($ZSH_CONFIG_DIR/completions $fpath)


typeset -U path
