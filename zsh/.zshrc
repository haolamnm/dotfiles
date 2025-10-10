#!/bin/zsh


### XDG STANDARDS
# REF: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"


### COMPINIT
# REF: https://scottspence.com/posts/speeding-up-my-zsh-shell
# REF: https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
ZCOMPDUMP="${ZCOMPDUMP:-$XDG_CACHE_HOME/zsh/.zcompdump}"
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' "$ZCOMPDUMP" 2>/dev/null)" ]; then
    compinit -d "$ZCOMPDUMP"
else
    compinit -C -d "$ZCOMPDUMP"
fi


### ANTIDOTE PLUGIN MANAGER
# REF: https://antidote.sh/usage
# REF: https://github.com/mattmc3/antidote
export ANTIDOTE_HOME="${ANTIDOTE_HOME:-$XDG_DATA_HOME/antidote}"
if [[ ! -d "$ANTIDOTE_HOME" ]]; then
    print -P "Installing mattmc3/antidote"
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_HOME"
fi
source "${ANTIDOTE_HOME}/antidote.zsh"
antidote load "$XDG_CONFIG_HOME/zsh/.zsh_plugins.txt"


### POWERLEVEL10K INSTANT PROMPT
# REF: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-configure-instant-prompt
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ -f "$XDG_CONFIG_HOME/zsh/.p10k.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/.p10k.zsh"


### ZSH CONFIGURATION DIRECTORY
export ZSH_HOME="${ZSH_HOME:-$XDG_CONFIG_HOME/zsh}"
[[ -d "$ZSH_HOME" ]] || mkdir -p "$ZSH_HOME"


### LOAD CONFIGURATION FILES
local config_files=(
    "$ZSH_HOME/path.zsh"
    "$ZSH_HOME/aliases.zsh"
    "$ZSH_HOME/functions.zsh"
    "$ZSH_HOME/history.zsh"
    "$ZSH_HOME/keybindings.zsh"
    "$ZSH_HOME/completions.zsh"
    "$ZSH_HOME/integrations.zsh"
)
for config_file in "${config_files[@]}"; do
    if [[ -f "$config_file" ]]; then
        source "$config_file"
    else
        print -P "Warning: Config file not found: $config_file"
    fi
done


### LOCAL OVERRIDES
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
[[ -f "$HOME/.zshenv" ]] && source "$HOME/.zshenv"


### CURSOR SHAPE BLOCK
function zle-line-init {
  emulate -L zsh
  printf '%s' ${terminfo[smkx]}
  print -n '\e[1 q'   # force block
}
zle -N zle-line-init
