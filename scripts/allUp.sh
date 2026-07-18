#!/bin/bash

url="https://0x0.st"

if command -v fd &>/dev/null; then
    # -t f: only files (faster)
    # -H: hidden files (optional, remove if unwanted)
    # --max-depth 4: prevents freezing on massive directory trees
	# -E .git: exclude .git directories
	# exclude python cache, node_modules, ~/.local/lib, ~/.cache, ~/.cargo, ~/.npm, ~/.nvm, ~/.pyenv, ~/.rbenv, ~/.rustup, ~/.vscode, and other common directories
    file=$(fd -t f -H \
            -E .git \
            -E __pycache__ \
            -E node_modules \
            -E .local \
            -E .cache \
            -E .cargo \
            -E .npm \
            -E .nvm \
            -E .pyenv \
            -E .venv \
            -E venv \
            -E .rbenv \
            -E rbenv \
            -E .rustup \
            -E .vscode \
            -E .wine \
            -E .wine32 \
            -E .wine64 \
            --color never \
            --base-directory "$HOME" | dmenu -i -l 10)
else
	exit 1
fi

[[ -z "$file" ]] && exit 0

curl -sL -A "Mozilla/5.0" -F "file=@$file" "$url" | xclip -selection c && notify-send "Uploaded!"

