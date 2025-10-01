#!/usr/bin/env zsh


### HISTORY NAVIGATION
# Up/Down arrows: Search history for commands starting with current input
# Example: Type "git" then press Up to see git commands from history
# bindkey "^[[A" history-search-backward  # Up arrow
# bindkey "^[[B" history-search-forward   # Down arrow

# Alternative: Use history-substring-search plugin (better)
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Ctrl+R: Fuzzy search history (uses fzf if available)
# Default behavior, just documenting
bindkey "^R" history-incremental-search-backward


### TEXT EDITING
# Ctrl+Left/Right: Move by word
bindkey "^[[1;5C" forward-word          # Ctrl+Right
bindkey "^[[1;5D" backward-word         # Ctrl+Left
bindkey '^H' backward-kill-word         # Ctrl+Backspace

# Ctrl+U to kill-whole-line

# Home/End: Jump to beginning/end of line
bindkey "^[[H" beginning-of-line        # Home
bindkey "^[[F" end-of-line              # End
