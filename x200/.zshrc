# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/duy/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="maran"

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

# alias youtube-dl="youtube-dl --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M'"
alias emoji="cat ~/gits/arch_config/.local/share/larbs/emoji"
alias push="git pull && git add . && git commit -m 'update' && git push"
alias t/sh="cd ~/.trash/sh"
alias t/p="cd ~/.trash/p"
alias t/c="cd ~/.trash/c"
alias sdb/v="cd ~/sdb/videos/"
alias lsf="ls -ap | grep -v '/'"
alias lsd="la -p | grep '/'"
alias p='cd /home/duy/gits/python'
alias t='cd /home/duy/.trash'
alias a='cd /home/duy/gits//arch_config'
alias start='systemctl start'
alias restart='systemctl restart'
alias status='systemctl status'
alias stop='systemctl stop'
alias wifi='sudo wifi-menu wls1'
alias wifi-menu='sudo wifi-menu'
alias rs='sudo netctl stop-all && sudo netctl restart wlp3s0-Tenda_106570'
alias emacs='emacs -nw'
alias -s gif='mpv --loop=0'
alias -s webm='mpv --loop=0'
alias pmsyu='sudo pacman -Syu'
alias pms='sudo pacman -S'
alias i3lock='i3lock -i /home/duy/Pictures/gnu_linux_1600x900.png'
alias d='~/Downloads'
alias D='~/Documents'
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -v'
alias ka='killall'
alias cf='cd ~/.config'
#
# alias mpv="mpv --ytdl-format='bestvideo[ext=mp4][height<=?720]+bestaudio[ext=m4a]'"
alias mpvi="mpv --ytdl-raw-options=write-sub=,write-auto-sub=,sub-lang=vi" 
alias mpvh="mpv --ytdl-format='[height<=1080]'"
alias mpvm="mpv --ytdl-format='[height<=720]'"
alias mpvl="mpv --ytdl-format='[height<=360]'"

# alias gvim='gvim -u NONE'
# set -o vi
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^e' edit-command-line
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
export KEYTIMEOUT=10
bindkey -M viins '^r' history-incremental-search-backward
 echo -ne '\e[5 q' # Cursor is beam instead of Block
# echo -ne "\033]12;Black\007" # Change cursor color

# Show vim mode
# Updates editor information when the keymap changes.
# function zle-keymap-select() {
#   zle reset-prompt
#   zle -R
# }
# 
# zle -N zle-keymap-select
# 
# function vi_mode_prompt_info() {
#   echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
# }
# 
# # define right prompt, regardless of whether the theme defined it
# RPS1='$(vi_mode_prompt_info)'
# RPS2=$RPS1



# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
export PATH="$PATH:$HOME/gits/arch_config/scripts"
export PATH="$PATH:$HOME/gits/arch_config/.local/bin/statusbar"
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
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

# export GTK_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus
# export QT_IM_MODULE=ibus
# 
# color for manpages
# export LESS_TERMCAP_mb=$'\e[1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'
 
# Manpages in vim
vman() {
  /usr/bin/man $@ | \
    col -b | \
    vim -R -c 'set ft=man nomod nolist' -
}
