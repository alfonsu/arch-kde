#!/bin/bash

start (){
sudo pacman -S dialog --needed --noconfirm
menu
}

menu (){
cmd=(dialog --cancel-label "Exit" --title "Menu" --separate-output --checklist "Select options:" 20 70 20)
options=(
1 "whdd" on
2 "hdsentinel " on
3 "hdsentinel_gui" on
4 "spectre-meltdown-checker" on
5 "qmplay2" on
6 "yt-dlp-drop-in" on
7 "youtubedl-gui" on
8 "svp" on
9 "mpv-git" on
10 "libstrangle-git" on
11 "clean" on
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
pamac build whdd --no-confirm
cp /var/cache/pacman/pkg/whdd* $HOME
;;
2)
pamac build hdsentinel --no-confirm
cp /var/cache/pacman/pkg/hdsentinel* $HOME
;;
3)
pamac build hdsentinel_gui --no-confirm
cp /var/cache/pacman/pkg/hdsentinel_gui* $HOME
;;
4)
pamac build spectre-meltdown-checker --no-confirm
cp /var/cache/pacman/pkg/spectre-meltdown-checker* $HOME
;;
5)
pamac build qmplay2 --no-confirm
cp /var/cache/pacman/pkg/qmplay2* $HOME
;;
6)
pamac build yt-dlp-drop-in --no-confirm
cp /var/cache/pacman/pkg/yt-dlp-drop-in* $HOME
;;
7)
pamac build youtubedl-gui --no-confirm
cp /var/cache/pacman/pkg/youtubedl-gui* $HOME
;;
8)
pamac build svp --no-confirm
cp /var/cache/pacman/pkg/svp* $HOME
;;
9)
pamac build mpv-git --no-confirm
cp /var/cache/pacman/pkg/mpv-git* $HOME
;;
10)
pamac build libstrangle-git --no-confirm
cp /var/cache/pacman/pkg/libstrangle-git* $HOME
;;
11)
pamac clean -b --no-confirm
yes | sudo pacman -Scc
;;
esac
done
case "$ret" in
*)
echo "----"
echo "Done"
echo "----"
exit
;;
esac
}

start
