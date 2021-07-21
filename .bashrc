#!/bin/bash

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


export PS1="  \[$(tput bold)\]\[$(tput setaf 1) \] λ  \w \\$\[$(tput sgr0)\]  "


#export PS1="\[\e[33m\] λ  \[\e[,\]\[]\e[36m\]@\[\e0\]:\[\e[35m\]\h\[\e[m\]] \[\e[31m\]\w[\e[m\]:\[\e[33m\]\\$\\[\e[m\] "

#export PS1="[\[\e[33m\]\u\[\e[,\]\[]\e[36m\]@\[\e0\]:\[\e[35m\]\h\[\e[m\]] \[\e[31m\]\w[\e[m\]:\[\e[33m\]\\$\\[\e[m\] "

[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts" # Load shortcut aliases


export EDITOR="vim"
export FILE="ranger"
export TERMINAL="st"
export PATH="$PATH:/usr/local/share/man/man1/"

export PATH="$PATH:/home/jon/.local/bin/i3cmds/"
export PATH="$PATH:/home/jon/.local/bin/tools/"
export PATH="$PATH:/home/jon/.local/bin/statusbar/"
export PATH="$PATH:/home/jon/.local/bin/cron/"
export PATH="$PATH:/home/jon/.local/bin/utilities/"

export PATH="$PATH:~/Downloads/Spine/"


# System Maintainence
alias mw="~/.config/mutt/mutt-wizard.sh"
alias sdn="sudo shutdown now"
alias psref="gpg-connect-agent RELOADAGENT /bye" # Refresh gpg
alias gua="git remote | xargs -L1 git push --all"

alias kys='echo "you first lil nigga"'
alias qtchan='cd ~/Documents/qtchan/build/ ; ./qtchan &'

# Some aliases
alias e="$EDITOR"
#alias ls='lsd'
alias incite='sudo pacman -Syyu'
alias brc='vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
alias xrc='vim ~/.Xresources'
alias cic='vim ~/.config/i3/config'
alias p="sudo pacman"
alias SS="sudo systemctl"
alias v="vim"
alias talk="nctelegram"
alias f="vifm"
alias r="ranger"
alias dd="w3m duckduckgo.com"
alias ka="killall"
alias g="git"
alias trem="transmission-remote"
alias mkd="mkdir -pv"
#alias ref="shortcuts >/dev/null ; source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
alias mpv="mpv --input-ipc-server=/tmp/mpvsoc$(date +%s)"
alias x="sxiv -ft *"
alias lp="pacman -Qett --color=always | less"
alias packer="yaourt"
alias ta="tmux attach"
alias sxhk="vim ~/.config/sxhkd/sxhkdrc"

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.
alias wow="/home/jon/Games/world-of-warcraft/drive_c/Program Files (x86)/World of Warcraft/_retail_/Wow.exe"


export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export DOWNGRADE_FROM_ALA=1


# Internet
alias ytv="youtube-dl --add-metadata -i" # Download video link
alias yta="yt --add-metadata -x -f bestaudio/best" # Download only audio
alias YT="youtube-viewer"

shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | grep location.href | grep -o http.*pdf) ;}
se() { du -a ~/.scripts/* ~/.config/* | awk '{print $2}' | fzf | xargs  -r $EDITOR ;}
sv() { vcopy "$(du -a ~/.scripts/* ~/.config/* | awk '{print $2}' | fzf)" ;}
vf() { fzf | xargs -r -I % $EDITOR % ;}

function exit() {
    if [ -n "$TMUX" ] && [ "$(basename $(echo $TMUX | cut -d, -f1))" = "awesome-termgrp" ]; then
        if [ $(tmux list-window | wc -l) -gt 1 ]; then
            tmux kill-window \; kill-session
        else
            tmux kill-window
        fi
    else
        builtin exit
    fi
}


export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"


#trying to resize
#export PROMPT_COMMAND="resize &>/dev/null ; $PROMPT_COMMAND"
