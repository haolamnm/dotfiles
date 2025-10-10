#!/bin/zsh


# Description: mkdir and cd into it
# Usage: mkcd dir
mkcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi
    mkdir -p "$1" && cd "$1" || return 1
}


# Description: Go up N directories
# Usage: up 3
up() {
    local d=""
    local limit="${1:-1}"
    for ((i=1; i<=limit; i++)); do
        d="../$d"
    done
    cd "$d" || return 1
}


# Description: Extract various archive types
# Usage: extract file.tar.gz
extract() {
    if [[ -z "$1" ]]; then
        echo "Usage: extract <file>"
        echo "Supported: .tar.gz, .tgz, .tar.bz2, .tbz2, .tar.xz, .zip, .rar, .7z, .gz, .bz2"
        return 1
    fi

    if [[ ! -f "$1" ]]; then
        echo "Error: '$1' is not a valid file"
        return 1
    fi

    case "$1" in
        *.tar.gz|*.tgz)     tar -xzf "$1" ;;
        *.tar.bz2|*.tbz2)   tar -xjf "$1" ;;
        *.tar.xz|*.txz)     tar -xJf "$1" ;;
        *.tar)              tar -xf "$1" ;;
        *.zip)              unzip "$1" ;;
        *.rar)              unrar x "$1" ;;
        *.7z)               7z x "$1" ;;
        *.gz)               gunzip "$1" ;;
        *.bz2)              bunzip2 "$1" ;;
        *.Z)                uncompress "$1" ;;
        *)                  echo "Error: '$1' cannot be extracted via extract()" ;;
    esac
}


# Description: Backup a file or directory with timestamp
# Usage: backup file.txt
backup() {
    if [[ -z "$1" ]]; then
        echo "Usage: backup <file_or_directory>"
        return 1
    fi
    local timestamp=$(date +%Y%m%d_%H%M%S)
    cp -r "$1" "${1}.backup_${timestamp}"
    echo "Created: ${1}.backup_${timestamp}"
}


# Description: Find file by name (case-insensitive)
# Usage: ff file.txt
ff() {
    if [[ -z "$1" ]]; then
        echo "Usage: ff <filename>"
        return 1
    fi
    fdfind -i "$1"
}


# Description: Find directory by name
# Usage: fd dir
fdir() {
    if [[ -z "$1" ]]; then
        echo "Usage: fdir <directory>"
        return 1
    fi
    fdfind -t d -i "$1"
}


# Description: Enhanced activate function with auto-detection
# Usage: activate [path]
activate() {
    # Deactivate any existing venv first
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate 2>/dev/null
    fi

    # If path provided, use it
    if [[ -n "$1" ]]; then
        if [[ -f "$1/bin/activate" ]]; then
            source "$1/bin/activate"
            return 0
        else
            echo "Error: No activate script found at $1/bin/activate"
            return 1
        fi
    fi

    # Auto-detect common venv names
    for venv_dir in .venv venv env .env; do
        if [[ -f "$venv_dir/bin/activate" ]]; then
            source "$venv_dir/bin/activate"
            echo "Activated: $venv_dir"
            return 0
        fi
    done

    echo "Info: No virtual environment found"
    ehco "Checked: .venv, venv, env, .env"
    return 1
}


# Description: Reload zsh configuration
# Usage: reload
reload() {
    source ~/.zshrc
    echo "Info: zsh configuration reloaded"
}
