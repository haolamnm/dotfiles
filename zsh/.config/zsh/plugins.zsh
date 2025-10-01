#!/usr/bin/env zsh


### POWERLEVEL10K THEME
zinit ice depth=1
zinit light romkatv/powerlevel10k


### UTILITIES (first)
# Bind to up/down arrows in keybindings.zsh
# Ref: https://github.com/zsh-users/zsh-history-substring-search
zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

# Ref: https://github.com/Aloxaf/fzf-tab
zinit ice wait lucid
zinit light Aloxaf/fzf-tab


### CORE PLUGINS
# Ref: https://github.com/zdharma-continuum/fast-syntax-highlighting
zinit ice wait lucid atinit"zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# Ref: https://github.com/zsh-users/zsh-completions
zinit ice wait lucid blockf atpull"zinit creinstall -q ."
zinit light zsh-users/zsh-completions

# Ref: https://github.com/zsh-users/zsh-autosuggestions
# Customize: ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
# Customize: ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
