#!/bin/bash

start (){
sudo pacman -Syy
sudo pacman -S dialog --needed --noconfirm
sudo pacman -S git --needed --noconfirm
menu
}

menu (){
cmd=(dialog --cancel-label "Exit" --title "Menu" --separate-output --checklist "Select options:" 17 70 10)
options=(
1 "Git Clone alfonsu/arch-kde" on
2 "Git Clone alfonsu/alfonsu_repo" off
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
rm -rf $HOME/arch-kde
git clone https://github.com/alfonsu/arch-kde $HOME/arch-kde
cd $HOME/arch-kde
chmod +x *.sh
;;
2)
rm -rf $HOME/alfonsu_repo
git clone https://github.com/alfonsu/alfonsu_repo $HOME/alfonsu_repo
cd $HOME/alfonsu_repo
chmod +x *.sh
cd $HOME/alfonsu_repo/x86_64
chmod +x *.sh
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
