#!/bin/zsh


### LIST UITLITY
alias ls="command ls --color=auto -F"
alias ll="command ls --color=auto -alFh"
alias la="command ls --color=auto -AF"
alias lsd="command ls --color=auto -d */"
alias lsda="command ls --color=auto -d .*/"


### SAFETY
alias rm="command rm -i"
alias cp="command cp -i"
alias mv="command mv -i"


### VERBOSE
alias mkdir="command mkdir -pv"
alias rmdir="command rmdir -v"


### HUMAN-READABLE
alias df="command df -h"              # Human-readable sizes
alias du="command du -h"
alias free="command free -h"


### SYSTEM
alias shutdown="sudo shutdown -h now"
alias reboot="sudo reboot"
alias suspend="systemctl suspend"


### BAT
if command -v batcat &>/dev/null; then
    alias bat="batcat --style=plain --color=always"
fi


### PREVIEW - FZF
alias preview="command fzf --preview 'batcat --style=plain --color=always {}'"


### GIT
alias gs="git status --short --branch"
alias gl="git log --oneline --decorate --graph --all --abbrev-commit"


### PYTHON
alias py="python3"
alias python="python3"


### NALA
alias apt="nala"


### LINUTIL
alias linutil="curl -fsSL https://christitus.com/linux | sh"
