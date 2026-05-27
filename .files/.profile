# # Amazon Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/.local/share/amazon-q/shell/profile.pre.bash" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/profile.pre.bash"
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export $(dbus-launch)

export IMSETTING_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# setxkbmap -option "ctrl:swapcaps"

# export _JAVA_AWT_WM_NONREPARENTING=1

# From .zshrc
export ANDROID_AVD_HOME=$HOME/.config/.android/avd
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export PATH="$PATH:$HOME/.rvm/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/gits/arch_config/scripts:$HOME/gits/arch_config/.local/bin/statusbar:$HOME/.cargo/bin:/home/duy/go:$HOME/gits/arch_config/scripts/shell-queue:/opt/flutter/bin"
export PATH=$PATH:$HOME/go/bin
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

# setxkbmap -option ctrl:swapcaps

# sudo sh -c "echo 10   >  /sys/devices/platform/i8042/serio1/serio2/drift_time"       # default 5 
# sudo sh -c "echo 200 > /sys/devices/platform/i8042/serio1/serio2/sensitivity"     # default 128
# sudo sh -c "echo 120 > /sys/devices/platform/i8042/serio1/serio2/speed"           # default 97

export VISUAL=nvim
export EDITOR=$VISUAL
export BROWSER="/usr/bin/google-chrome-stable"

export SHELL=/usr/bin/zsh

# ./.fehbg
[ ! -e ~/.config/mpd/pid ] && mpd
# sh -c mpd > /dev/null
# ./.config/polybar/launch_polybar > /dev/null 2>&1 

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export LF_ICONS="di=:\
fi=:\
tw=🤝:\
ow=:\
ln=:\
or=❌:\
ex=:\
*.conf=:\
*.db=:\
*.sh=:\
*.txt=:\
*.json={;}:\
*.xml=</>:\
*.py=:\
*.php=:\
*.js=:\
*.c=:\
*.cpp=:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=:\
*.jpe=:\
*.jpeg=:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.gpg=:\
*.css=:\
*.pdf=:\
*.djvu=📚:\
*.epub=:\
*.csv=:\
*.xlsx=:\
*.docx=:\
*.doc=:\
*.tex=📜:\
*.md=:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=♬:\
*.opus=♬:\
*.ogg=♬:\
*.m4a=♬:\
*.flac=:\
*.mkv=:\
*.mp4=:\
*.webm=🎬:\
*.mpeg=🎬:\
*.avi=🎬:\
*.m4v=🎬:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.gz=📦:\
*.tar=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=:\
*.nfo=:\
*.info=:\
*.log=📙:\
*.iso=💿:\
*.img=:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=:\
*.jar=♨:\
*.java=♨:\
"

# Amazon Q post block. Keep at the bottom of this file.
# [[ -f "${HOME}/.local/share/amazon-q/shell/profile.post.bash" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/profile.post.bash"
