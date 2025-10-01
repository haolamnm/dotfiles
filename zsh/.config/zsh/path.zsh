#!/usr/bin/env zsh


### HELPER FUNCTIONS
# Add directory to PATH if it exists and isn't already in PATH
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


### USER LOCAL BINARIES
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"


### DEVELOPMENT TOOLS
# Cargo (Rust)
if [[ -d "$HOME/.cargo/bin" ]]; then
    path_append "$HOME/.cargo/bin"
fi

# Flatpak
if [[ -d "/var/lib/flatpak/exports/bin" ]]; then
    path_append "/var/lib/flatpak/exports/bin"
fi


### PAGER
if command -v batcat &>/dev/null; then
    export PAGER="batcat"
    # export BAT_THEME="default"
elif command -v less &>/dev/null; then
    export PAGER="less"
    export LESS="-R -F -X"  # -R: colors, -F: quit if one screen, -X: no init
else
    export PAGER="more"
fi

# Man pages with color
export MANPAGER="sh -c 'batcat -l man -p'" 2>/dev/null || export MANPAGER="less"


### DEVELOPMENT VARIABLES
# Python
# export PYTHONDONTWRITEBYTECODE=1  # Don't create .pyc files
# export PYTHONUNBUFFERED=1         # Unbuffered output


### APPLICATION-SPECIFIC VARIABLES
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height 60% --layout=reverse --border}"

# Ripgrep config file
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"

# Less history file location
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# Wget config file
export WGETRC="$XDG_CONFIG_HOME/wget/.wgetrc"


### PATH CLEANUP
# Remove duplicates from PATH while preserving order
# This is handled by zsh automatically with 'typeset -U path'
typeset -U path
