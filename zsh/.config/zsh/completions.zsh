#!/bin/zsh


### BEHAVIOR
# Case-insensitive (all), partial-word, and substring completion
# 'm:{a-zA-Z}={A-Za-z}' - Case insensitive matching
# 'r:|[._-]=* r:|=*'    - Partial word completion (foo-bar matches f-b)
# 'l:|=* r:|=*'         - Substring completion
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' \
    'l:|=* r:|=*'


#### ZSTYLE
# Use LS_COLORS for file/directory coloring in completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group completions by type
zstyle ':completion:*' group-name ''

# Disable old menu, use fzf-tab instead
zstyle ':completion:*' menu no

# Show completion menu on successive tab press
zstyle ':completion:*' menu select=1

# Disable sort for better results
# REF: https://github.com/Aloxaf/fzf-tab
zstyle ':completion:*' file-sort modification

# Preview directory contents when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'command ls --color=auto -AF $realpath'

# Preview directory contents for zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'command ls --color=auto -AF $realpath'

# Preview file contents when completing cat, bat, less, etc.
zstyle ':fzf-tab:complete:(bat|batcat|cat|less|more|nano|vi|vim|nvim):*' \
    fzf-preview 'batcat --style=plain --color=always --line-range=:500 $realpath 2>/dev/null || cat $realpath 2>/dev/null'

# Preview for git commands
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
    'git diff --color=always $word | delta 2>/dev/null || git diff --color=always $word'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
    'git log --color=always --format="%C(auto)%h %C(blue)%an %C(yellow)%ar%C(auto)%d %s" $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
    'git show --color=always $word | delta 2>/dev/null || git show --color=always $word'

# Preview for environment variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
    fzf-preview 'echo ${(P)word}'

# Preview for man pages
zstyle ':fzf-tab:complete:(man|tldr):*' fzf-preview \
    'tldr --color always $word 2>/dev/null || man $word 2>/dev/null | batcat --color=always --style=plain --language=man'

# Set fzf options for different contexts
zstyle ':fzf-tab:*' fzf-flags --height=50% --layout=reverse --border

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Don't complete backup files as commands
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*\~'

# Complete command options
zstyle ':completion:*' complete-options true


### COMPLETION OPTIONS
setopt AUTO_CD           # cd by typing directory name if not a command
setopt AUTO_PUSHD        # Make cd push old directory to stack
setopt PUSHD_IGNORE_DUPS # Don't push duplicates
setopt PUSHD_SILENT      # Don't print directory stack


# COMPLETE HIDDEN FILES
_comp_options+=(globdots)
