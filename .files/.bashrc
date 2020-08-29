#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
PS1='[\e[0;34m\u\e[m@\e[0;33m\h\e[m:\e[0;32m$PWD\e[m]\n\$ '
PS2='> '

# Customize
set -o vi

# Bind field
bind 'TAB:menu-complete'
bind '"jk":vi-movement-mode'
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-command 'u: undo'
bind -m vi-command '/: vi-search'
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert 'TAB: menu-complete'
bind -m vi-insert '"\e[Z": menu-complete-backward'
bind -m vi-insert 'Control-e: edit-and-execute-command'


# eport field
export MANPATH="/usr/local/man:$MANPATH"
export HISTFILE=~/.bash_history
export HISTSIZE=999999999
export HISTCONTROL=ignoreboth:erasedups
export SAVEHIST=$HISTSIZE
# color for manpage
# export LESS_TERMCAP_mb=$'\e[1;32m' # light yellow
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;31m' # red # search
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;33m' # dark yellow
export FZF_DEFAULT_COMMAND="find -L"


# alias field
alias msfconsole="msfconsole --quiet -x \"db_connect nnd@msf\""
alias emacs="emacs -nw"
alias pscpu=" ps -eo cmd,%mem,%cpu --sort=-%cpu| less"
alias psmem=" ps -eo cmd,%mem,%cpu --sort=-%mem| less"
alias vi="vim -u NONE"
alias youtube-dl="youtube-dl --write-auto-sub --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M'"
alias emoji="cat ~/gits/arch_config/.local/share/larbs/emoji"
alias lsf="ls -ap | grep -v '/'"
alias lsd="la -p | grep '/'"
alias p='cd /home/duy/gits/python'
alias t='cd /home/duy/.trash'
alias a='cd /home/duy/gits/arch_config'
alias start='systemctl start'
alias restart='systemctl restart'
alias status='systemctl status'
alias stop='systemctl stop'
alias wifi='sudo wifi-menu wlp3s0'
alias wifi-menu='sudo wifi-menu'
alias rst='sudo netctl stop-all && sudo netctl start wlp3s0-Tenda_106570'
alias rsa='sudo netctl stop-all && sudo netctl start wlp3s0-abc.xyz'
alias rsn='sudo netctl stop-all && sudo netctl start wlp3s0-nguyenngocanh'
alias pmsyu='sudo pacman -Syu'
alias pmsy='sudo pacman -Sy'
alias pms='sudo pacman -S'
alias pmr='sudo pacman -R'
alias i3lock="i3lock -k"
alias d='cd ~/Downloads'
alias D='cd ~/Documents'
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -v'
alias ka='killall'
alias cf='cd ~/.config'
alias aircrack="aircrack-ng -w ~/gits/wordlists/wifi-chua.txt"
alias mpvi="mpv --ytdl-raw-options=write-sub=,write-auto-sub=,sub-lang=vi" 
alias mpvh="mpv --ytdl-format='[height<=1080]'"
alias mpvm="mpv --ytdl-format='[height<=720]'"
alias mpvl="mpv --ytdl-format='[height<=360]'"

# function field
vman() {
  /usr/bin/man $@ | \
    col -b | \
    vim -R -c 'set ft=man nomod nolist' -
}

ytv()
{
    mpv --ytdl-format='bestvideo[ext=mp4][height<=?360]+bestaudio[ext=m4a]' ytdl://ytsearch:"$*"
}

yta()
{
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

