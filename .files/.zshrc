# # Amazon Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/duy/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# export BROWSER="/usr/bin/firefox"
# xdg-settings set default-web-browser firefox.desktop

aria2c_() {
    aria2c -x 8 --seed-time=0 $*
}
alias lf="lfub"
alias pscpu="ps -eo pid,cmd,%mem,%cpu --sort=-%cpu| less"
alias psmem="ps -eo pid,cmd,%mem,%cpu --sort=-%mem| less"
alias vi="vim -u NONE"
alias emoji="cat ~/gits/arch_config/.local/share/emoji"

dps() {sudo docker ps -a}
dup() {sudo docker-compose up}
drmi() {
	[[ -z $(sudo docker ps -q) ]] && echo "No running container" && sudo docker rmi -f `sudo docker images -aq | paste -sd ' '`
	[[ ! -z $(sudo docker ps -q) ]] && sudo docker stop `sudo docker ps -q | paste -st ' '` && sudo docker rmi -f `sudo docker images -aq | paste -sd ' '`
}
dstop() {sudo docker stop `sudo docker ps -q | paste -sd ' '`}
drmc() {
	[[ -z $(sudo docker ps -q) ]] && echo "No running container" && sudo docker container rm `sudo docker ps -aq | paste -sd ' '`
	[[ ! -z $(sudo docker ps -q) ]] && sudo docker stop `sudo docker ps -q | paste -st ' '` && sudo docker container -rm `sudo docker ps -aq | paste -sd ' '`
}
alias t='cd /home/duy/.trash'
alias a='cd /home/duy/gits/arch_config'
alias start='sudo systemctl start'
alias restart='sudo systemctl restart'
alias status='sudo systemctl status'
alias stop='sudo systemctl stop'
alias wifi='sudo wifi-menu'
alias emacs='emacs -nw'
alias -s gif='mpv --loop=0'
alias -s webm='mpv --loop=0'
alias pmsyu='sudo pacman -Syu'
alias pmsy='sudo pacman -Sy'
alias pms='sudo pacman -S'
alias pmr='sudo pacman -R'
alias d='~/Downloads'
alias D='~/Documents'
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -v'
alias ka='sudo killall'

alias mpvi="mpv --ytdl-raw-options=write-sub=,write-auto-sub=,sub-lang=vi" 
alias mpvh="mpv --ytdl-format='[height<=1080]'"
alias mpvm="mpv --ytdl-format='[height<=720]'"
alias mpvl="mpv --ytdl-format='[height<=360]'"
alias mpvc="proxychains mpv --ytdl-format='[height<=?720]'"


bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^e' edit-command-line
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
export KEYTIMEOUT=10
bindkey -M viins '^r' history-incremental-search-backward
# bindkey '^F' autosuggest-accept
# echo -ne '\e[4 q' # Cursor is underscore instead of Block
# Cursor settings:
#   1 -> blinking block
#   2 -> solid block 
#   3 -> blinking underscore
#   4 -> solid underscore
#   5 -> blinking vertical bar
#   6 -> solid vertical bar

# Change cursor color
#  echo -ne "\033]12;Neon\007" 

# Show vim mode
# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
	[[ $? -ne 0 ]] && echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%} :(" || echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%} :)"
}
# 
# # define right prompt, regardless of whether the theme defined it
PS1='%F{blue}%*%f %F{green}%~%f $(git_prompt_info)
$ '
# RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

export HISTFILE=~/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space


autoload -Uz tetriscurses
alias tetris='tetriscurses'

ytv()
{
    mpv --ytdl-format='bestvideo[ext=mp4][height<=?360]+bestaudio[ext=m4a]' ytdl://ytsearch:"$*"
}
yta()
{
    mpv --loop=inf --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

ytal()
{
    mpv --loop=inf --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

# Manpages in vim
vman() {
  /usr/bin/man $@ | \
    col -b | \
    vim -R -c 'set ft=man nomod nolist' -
}

streamlink_() {
	streamlink -p mpv "$*" best
}

mp3-dl() {
	youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0 "$*"
}

mp3pl-dl() {
	youtube-dl -ict --yes-playlist --extract-audio --audio-format mp3 --audio-quality 0 "$*"
}
ari() {
    aria2c -c -x3 --seed-time=0 "$*"
}

yays() { yay -Fy; yay -Slq | fzf --height=100% --multi --preview 'yay -Si {1}' | xargs -ro yay -S --needed ;}
pmss() { sudo pacman -Fy; pacman -Slq | fzf --height=100% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S --needed ;}

ssl_check() {
	# $* = host:port
	openssl s_client -connect $*
}

export FZF_DEFAULT_COMMAND="fd --type f"

function cd() {
  if [[ -d ./.venv ]] ; then
    deactivate
  fi
  builtin cd $1
  if [[ -d ./venv ]] ; then
    source ./venv/bin/activate
	export PYTHONPATH=$PWD
  fi
  if [[ -d ./.venv ]] ; then
    source ./.venv/bin/activate
	export PYTHONPATH=$PWD
  fi
}

rm_pycache() {
	rm -rf `find ./** -type d -name "__pycache__"`
}

psfind() {
    # Extract the first letter and the rest of the string cleanly
    local first="${1:0:1}"
    local rest="${1:1}"
    
    # Run the command
    ps aux | awk "NR==1 || /[$first]$rest/"
}
treefind() {
    # Default to line 1 if the second argument is missing
    local line_num="${2:-1}"
    
    # Get the PID from the specific line using sed
    local pid=$(pgrep -f "$1" | sed -n "${line_num}p")
    
    if [ -z "$pid" ]; then
        echo "No running process found for '$1' at line $line_num"
        echo "Available PIDs for '$1':"
        pgrep -fl "$1"
        return 1
    fi
    
    # Show the parent tree for that specific PID
    pstree -sp "$pid"
}
