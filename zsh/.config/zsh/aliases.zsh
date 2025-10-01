#!/usr/bin/env zsh


### LIST
alias ls="ls --color=auto -CF"
alias ll="ls --color=auto -alF"
alias la="ls --color=auto -A"
alias lsd="command ls --color=auto -d */"
alias lsda="command ls --color=auto -d .*/"  # Include hidden directories


### BAT
alias bat="batcat"


### SAFETY
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"


### BETTER DEFAULTS
alias mkdir="mkdir -pv"  # Create parent dirs + verbose
alias rmdir="rmdir -v"   # Verbose


### BAT
if command -v bat &>/dev/null; then
    alias cat="bat --style=auto"
    alias catt="/usr/bin/cat"  # Original cat
    alias bathelp="bat --list-themes && echo 'Set theme: export BAT_THEME=<theme>'"
fi

# Quick file preview
alias preview="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"


### SYSTEM & PROCESS MANAGEMENT
# Clear screen
alias c="clear"
alias cls="clear"

# System information
alias df="df -h"              # Human-readable sizes
alias du="du -h"              # Human-readable sizes
alias free="free -h"          # Human-readable sizes
alias diskspace="du -h --max-depth=1 | sort -hr"

# Process management
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"  # Search processes
alias htop="htop || top"      # Fallback to top if htop not installed

# System shortcuts
alias shutdown="sudo shutdown -h now"
alias reboot="sudo reboot"
alias suspend="systemctl suspend"


### GIT
alias g="git"
alias gs="git status --short --branch"
alias gl="git log --oneline --decorate --graph --all --abbrev-commit"


### PYTHON
alias py="python3"
alias python="python3"
alias pip="uv pip"
alias venv="uv venv"


### FD - BETTER FIND
alias fd="fdfind"
alias find="fdfind"


### NALA
alias nala="apt"
