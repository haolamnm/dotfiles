#!/usr/bin/env zsh


### POWERLEVEL10K INSTANT PROMPT
# Ref: https://github.com/romkatv/powerlevel10k#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### XDG STANDARDS
# Ref: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"


### ZSH CONFIGURATION DIRECTORY
export ZSH_CONFIG_DIR="${ZSH_CONFIG_DIR:-$XDG_CONFIG_HOME/zsh}"


### ZINIT
# Ref: https://github.com/zdharma-continuum/zinit
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"

# Auto-install zinit if not present
if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "Installing zdharma-continuum/zinit"
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "Installation successful" || \
        print -P "The clone has failed"
fi
source "${ZINIT_HOME}/zinit.zsh"


### LOAD CONFIGURATION FILES
# Create config directory if it doesn't exist
[[ -d "$ZSH_CONFIG_DIR" ]] || mkdir -p "$ZSH_CONFIG_DIR"

# Note: Order matters - some configs depend on others
local config_files=(
    "$ZSH_CONFIG_DIR/plugins.zsh"      # Plugins (first)
    "$ZSH_CONFIG_DIR/aliases.zsh"      # Aliases
    "$ZSH_CONFIG_DIR/history.zsh"      # History configuration
    "$ZSH_CONFIG_DIR/completions.zsh"  # Completion system
    "$ZSH_CONFIG_DIR/keybindings.zsh"  # Key bindings
    "$ZSH_CONFIG_DIR/functions.zsh"    # Custom functions
    "$ZSH_CONFIG_DIR/integrations.zsh" # External tool integrations
    "$ZSH_CONFIG_DIR/path.zsh"         # PATH configuration (last)
)
for config_file in "${config_files[@]}"; do
    if [[ -f "$config_file" ]]; then
        source "$config_file"
    else
        print -P "Warning: Config file not found: $config_file"
    fi
done


### POWERLEVEL10K CONFIGURATION
# Run 'p10k configure' to customize prompt
[[ -f "$ZSH_CONFIG_DIR/.p10k.zsh" ]] && source "$ZSH_CONFIG_DIR/.p10k.zsh"


### LOAD OVERRIDES
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
[[ -f "$HOME/.zshenv" ]] && source "$HOME/.zshenv"


### CURSOR SHAPE BLOCK
function zle-line-init {
  emulate -L zsh
  printf '%s' ${terminfo[smkx]}
  print -n '\e[1 q'   # force block
}
zle -N zle-line-init
