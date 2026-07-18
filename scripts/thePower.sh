#!/bin/bash

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
case $(file --mime-type "$file" -b) in
	text/html) $BROWSER "$file" >/dev/null 2>&1 &;;
	text/*) st -e nvim "$file" &;;
	audio/*) mpv "$file" >/dev/null 2>&1 &;;
	video/*) mpv "$file" >/dev/null 2>&1 &;;
	image/gif) mpv --loop=inf "$file" &;;
	image/*) sxiv -b "$file" &;;
	application/pdf) zathura "$file" >/dev/null 2>&1 & ;;
	application/epub+zip) FBReader "$file" >/dev/null 2>&1 &;;
	application/vnd.openxmlformats-officedocument.wordprocessingml.document) libreoffice "$file" &;;
	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet) libreoffice "$file" &;;
esac
