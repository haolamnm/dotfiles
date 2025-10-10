#!/bin/zsh


### TEXT EDITING
bindkey "^[[1;5C" forward-word         # Ctrl + right
bindkey "^[[1;5D" backward-word        # Ctrl + left
bindkey '^H' backward-kill-word        # Ctrl + backspace


### JUMP UTILITY
bindkey "^[[H" beginning-of-line        # Home
bindkey "^[[F" end-of-line              # End
