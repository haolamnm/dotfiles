#!/usr/zsh


### FZF
# REF: https://github.com/junegunn/fzf
if command -v fzf &>/dev/null; then
    # Shell integration (Ctrl+R, Ctrl+T, Alt+C)
    eval "$(fzf --zsh 2>/dev/null)" || {
        # Fallback for older fzf versions
        [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
    }

    # FZF Configuration
    export FZF_DEFAULT_OPTS="
        --height 50%
        --layout=reverse
        --border
        --bind 'ctrl-/:toggle-preview'
        --bind 'ctrl-a:select-all'
        --bind 'ctrl-y:execute-silent(echo -n {+} | pbcopy)'
        --preview-window=right:60%:wrap
    "

    # Use fd for better file listing (if available)
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude .git'
    elif command -v rg &>/dev/null; then
        # Fallback to ripgrep
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi

    # Preview files with bat or cat
    if command -v batcat &>/dev/null; then
        export FZF_CTRL_T_OPTS="
            --preview 'batcat --style=plain --color=always --line-range=:500 {}'
            --preview-window=right:60%:wrap
        "
    else
        export FZF_CTRL_T_OPTS="
            --preview 'cat {}'
            --preview-window=right:60%:wrap
        "
    fi

    export FZF_ALT_C_OPTS="
        --preview 'ls -alFgGh --color=always {}'
        --preview-window=right:60%:wrap
    "
fi
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height 60% --layout=reverse --border}"


### ZOXIDE
# REF: https://github.com/ajeetdsouza/zoxide
if command -v zoxide &>/dev/null; then
    # Initialize zoxide (replaces cd with smart jump)
    eval "$(zoxide init --cmd cd zsh)"

    # Aliases for zoxide
    alias zd="zoxide query -i"  # Interactive selection
    alias zq="zoxide query"     # Query without jumping
    alias zr="zoxide remove"    # Remove path
fi


### SSH AGENT
# Start ssh-agent if not running
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    eval "$(ssh-agent -s)" >/dev/null
fi


### RUST
if [[ -f "$XDG_DATA_HOME/cargo/env" ]]; then
    source "$XDG_DATA_HOME/cargo/env"
fi


### BAT - PAGER
if command -v batcat &>/dev/null; then
    export PAGER="batcat --style=plain --color=always"
elif command -v less &>/dev/null; then
    export PAGER="less"
    export LESS="-R -F -X"  # -R: colors, -F: quit if one screen, -X: no init
else
    export PAGER="more"
fi
export MANPAGER="zsh -c 'batcat --color=always --style=plain --language=man'" 2>/dev/null || export MANPAGER="less"


### NANO
export EDITOR="nano"


### RIPGREP
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"


### RUST - CARGO
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"


### WGET
export WGETRC="$XDG_CONFIG_HOME/wget/.wgetrc"


### LESS
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
