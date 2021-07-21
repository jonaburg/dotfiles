#!/bin/bash

#extracts all contents of backup into functional arch based system (personal)
#
extract(){
# syncing over ~/.config to new dir.
rsync -av .config/awesome ~/.config/
rsync -av .config/dunst   ~/.config/
rsync -av .config/joplin    ~/.config/
rsync -av .config/fontconf ~/.config/
rsync -av .config/lf      ~/.config/
rsync -av .config/ncmpcpp ~/.config/
rsync -av .config/newsboat ~/.config/
rsync -av .config/nvim  ~/.config/
rsync -av .config/rofi   ~/.config/
rsync -av .config/st     ~/.config/
rsync -av .config/mpv    ~/.config/
rsync -av .config/mpd    ~/.config/
rsync -av .config/sxhkd  ~/.config/
rsync -av .config/sxiv   ~/.config/
rsync -av .config/zathura ~/.config/
rsync -av .config/compton ~/.config/
rsync -av .config/emoji   ~/.config/
rsync -av .config/fontawesome ~/.config/
rsync -av .config/compton.conf ~/.config/compton.conf
rsync -av .config/picom.conf ~/.config/picom.conf
rsync -av .config/aliasrc ~/.config/aliasrc


#syncing homedir files
rsync -av .abook ~/
rsync -av .mozilla/firefox/kvglthvf.default-release  ~/
rsync -av .parsec ~/
rsync -av .bash_profile ~/
rsync -av .bashrc ~/
rsync -av .dir_colors ~/
rsync -av .inputrc ~/
rsync -av .profile ~/
rsync -av .tmux.conf ~/
rsync -av .tmux.conf.backup ~/
rsync -av .vimrc ~/
rsync -av .xinitrc ~/
rsync -av .xprofile ~/
rsync -av .Xresources ~/
rsync -av .zshrc ~/

# syncing Documents/Xresources/folder
rsync -av Documents/Xresources ~/Documents/

# syncing crontab(s)
rsync -av Documents/cronmemory ~/Documents/

# syncing most script(s)
rsync -av .local/bin ~/.local/

#syncing st build
rsync -av .local/backups/st ~/Documents/



}
"$@"
