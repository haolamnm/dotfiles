#!/usr/bin/env zsh


### HISTORY FILE LOCATION
HISTFILE="${XDG_STATE_HOME}/zsh/history"

# Create history directory if it doesn't exist
[[ -d "$(dirname "$HISTFILE")" ]] || mkdir -p "$(dirname "$HISTFILE")"

# History size in memory and on disk
HISTSIZE=10000              # Lines to keep in memory
SAVEHIST=10000              # Lines to save to file


### HISTORY OPTIONS
# Basics
setopt APPEND_HISTORY         # Append rather than overwrite history file
setopt EXTENDED_HISTORY       # Record timestamp of command in HISTFILE
setopt HIST_VERIFY            # Show command with history expansion before running
setopt SHARE_HISTORY          # Share history between all sessions

# Duplicate management
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file
setopt HIST_FIND_NO_DUPS      # Don't display duplicates when searching
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming

# Privacy
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space (privacy)
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording
setopt HIST_NO_STORE          # Don't store 'history' or 'fc' commands

# Additional stuff
setopt HIST_IGNORE_DUPS       # Don't record consecutive duplicate commands
setopt HIST_BEEP              # Beep when accessing nonexistent history
setopt INC_APPEND_HISTORY     # Write to history file immediately, not on exit


### IGNORE
# Bash shell
export HISTIGNORE="ls:pwd:clear:note"

# ZSH shell: Ignore some commands from history
zshaddhistory() {
  emulate -L zsh
  [[ $1 == (note*) ]] && return 1
  return 0
}
