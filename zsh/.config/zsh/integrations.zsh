#!/usr/bin/env zsh


### FZF: Fuzzy Finder
# Install: https://github.com/junegunn/fzf
if command -v fzf &>/dev/null; then
    # Shell integration (Ctrl+R, Ctrl+T, Alt+C)
    eval "$(fzf --zsh 2>/dev/null)" || {
        # Fallback for older fzf versions
        [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
    }

    # FZF Configuration
    export FZF_DEFAULT_OPTS="
        --height 60%
        --layout=reverse
        --border
        --inline-info
        --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
        --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
        --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
        --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
        --bind 'ctrl-/:toggle-preview'
        --bind 'ctrl-a:select-all'
        --bind 'ctrl-y:execute-silent(echo -n {+} | pbcopy)'
        --preview-window=right:60%:wrap
    "

    # Use fd for better file listing (if available)
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    elif command -v rg &>/dev/null; then
        # Fallback to ripgrep
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi

    # Preview files with bat or cat
    if command -v bat &>/dev/null; then
        export FZF_CTRL_T_OPTS="
            --preview 'bat --style=numbers --color=always --line-range :500 {}'
            --preview-window=right:60%:wrap
        "
    else
        export FZF_CTRL_T_OPTS="
            --preview 'cat {}'
            --preview-window=right:60%:wrap
        "
    fi

    # Preview directories with tree or ls
    if command -v tree &>/dev/null; then
        export FZF_ALT_C_OPTS="
            --preview 'tree -C {} | head -200'
            --preview-window=right:60%:wrap
        "
    else
        export FZF_ALT_C_OPTS="
            --preview 'ls -la --color=always {}'
            --preview-window=right:60%:wrap
        "
    fi
fi


### ZOXIDE: BETTER CD
# Install: https://github.com/ajeetdsouza/zoxide
if command -v zoxide &>/dev/null; then
    # Initialize zoxide (replaces cd with smart jump)
    eval "$(zoxide init --cmd cd zsh)"

    # Aliases for zoxide
    alias zi="zoxide query -i"  # Interactive selection
    alias zq="zoxide query"     # Query without jumping
    alias zr="zoxide remove"    # Remove path

    # Note: After init, 'cd' becomes zoxide-powered
    # - 'cd foo' will jump to most frecent directory matching foo
    # - 'cd foo bar' will match directories with both foo and bar
    # - 'cd ~' and 'cd -' still work as expected
fi


### FNM: FAST NODE MANAGER
# Install: https://github.com/Schniz/fnm
if [[ -d "$HOME/.local/share/fnm" ]]; then
    export FNM_PATH="$HOME/.local/share/fnm"
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --use-on-cd)"

    # Auto-use node version from .node-version or .nvmrc
    # This is handled by --use-on-cd flag
elif command -v fnm &>/dev/null; then
    # If fnm is installed via package manager
    eval "$(fnm env --use-on-cd)"
fi


### SSH AGENT
# Start ssh-agent if not running
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    eval "$(ssh-agent -s)" >/dev/null
fi


### RUST
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi
