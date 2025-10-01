#!/usr/bin/env zsh


### AUTOLOAD COMPLETION SYSTEM
autoload -Uz compinit

# Speed up compinit by checking cache once per day
# Ref: https://gist.github.com/ctechols/ca1035271ad134841284
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Load bashcompinit for bash completion compatibility
autoload -Uz bashcompinit && bashcompinit


### BEHAVIOR
# Case-insensitive (all), partial-word, and substring completion
# 'm:{a-zA-Z}={A-Za-z}' - Case insensitive matching
# 'r:|[._-]=* r:|=*'    - Partial word completion (foo-bar matches f-b)
# 'l:|=* r:|=*'         - Substring completion
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' \
    'l:|=* r:|=*'


### VISUAL STYLING
# Use LS_COLORS for file/directory coloring in completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group completions by type
zstyle ':completion:*' group-name ''

# Add descriptions to completion groups
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# Warnings for no matches
zstyle ':completion:*:warnings' format '%F{red}-- No matches found --%f'

# Format for corrections
zstyle ':completion:*:corrections' format '%F{yellow}-- %d (errors: %e) --%f'

# Messages during completion
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'


### MENU & SELECTION
# Disable old menu, use fzf-tab instead
zstyle ':completion:*' menu no

# Show completion menu on successive tab press
zstyle ':completion:*' menu select=1


### FZF-TAB CONFIGURATION
# Ref: https://github.com/Aloxaf/fzf-tab
# Disable sort for better results
zstyle ':completion:*' file-sort modification

# Preview directory contents when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'

# Preview directory contents for zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=always $realpath'

# Preview file contents when completing cat, bat, less, etc.
zstyle ':fzf-tab:complete:(bat|cat|less|more|nano|vi|vim|nvim):*' \
    fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath 2>/dev/null || cat $realpath 2>/dev/null'

# Preview for git commands
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
    'git diff --color=always $word | delta 2>/dev/null || git diff --color=always $word'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
    'git log --color=always --format="%C(auto)%h %C(blue)%an %C(yellow)%ar%C(auto)%d %s" $word'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
    'git show --color=always $word | delta 2>/dev/null || git show --color=always $word'

# Preview for systemctl
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Preview for environment variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
    fzf-preview 'echo ${(P)word}'

# Preview for processes (kill, ps, etc.)
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# Preview for man pages
zstyle ':fzf-tab:complete:(man|tldr):*' fzf-preview \
    'tldr --color always $word 2>/dev/null || man $word 2>/dev/null | bat --color=always --plain --language=man'

# Set fzf options for different contexts
zstyle ':fzf-tab:*' fzf-flags --height=80% --layout=reverse --border --margin=1 --padding=1

# Switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'


### COMMAND-SPECIFIC COMPLETIONS
# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Don't complete backup files as commands
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*\~'

# Complete command options
zstyle ':completion:*' complete-options true


### PROCESS & KILL COMPLETIONS
# Sort processes by CPU usage
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps xo pid,user,comm'

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache avahi backup bin bind clamav daemon dbus \
    ftp games gdm gnats haldaemon halt htdig ident junkbust ldap \
    lp mail mailnull mldonkey mysql named netdump news nfsnobody \
    nobody nscd ntp nut operator pcap postfix postgres proxy pulse \
    pvm quagga radvd rpc rpcuser rpm shutdown squid sshd sync sys \
    syslog uucp vcsa xfs '_*'


### SSH / SCP / RSYNC HOSTNAME COMPLETIONS
# Complete hostnames from SSH config and known_hosts
zstyle ':completion:*:(ssh|scp|rsync):*' hosts 'reply=(
    ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[# ]*}//,/ }
    ${=${(f)"$(cat /etc/hosts(|)(N) 2>/dev/null)"}%%\#*}
)'


### DIRECTORY COMPLETIONS
# Expand =command to command's path
setopt AUTO_CD           # cd by typing directory name if not a command
setopt AUTO_PUSHD        # Make cd push old directory to stack
setopt PUSHD_IGNORE_DUPS # Don't push duplicates
setopt PUSHD_SILENT      # Don't print directory stack

# Complete hidden files
_comp_options+=(globdots)
