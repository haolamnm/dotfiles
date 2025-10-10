#!/bin/zsh


### HISTORY FILE LOCATION
HISTFILE="${XDG_STATE_HOME}/zsh/history"
[[ -d "$(dirname "$HISTFILE")" ]] || mkdir -p "$(dirname "$HISTFILE")"

HISTSIZE=10000              # Lines to keep in memory
SAVEHIST=10000              # Lines to save to file


### OPTIONS
setopt APPEND_HISTORY         # Append rather than overwrite history file
setopt EXTENDED_HISTORY       # Record timestamp of command in HISTFILE
setopt HIST_VERIFY            # Show command with history expansion before running
setopt SHARE_HISTORY          # Share history between all sessions

setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file
setopt HIST_FIND_NO_DUPS      # Don't display duplicates when searching
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming

setopt HIST_IGNORE_SPACE      # Don't record commands starting with space (privacy)
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording
setopt HIST_NO_STORE          # Don't store 'history' or 'fc' commands

setopt HIST_IGNORE_DUPS       # Don't record consecutive duplicate commands
setopt INC_APPEND_HISTORY     # Write to history file immediately, not on exit
