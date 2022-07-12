#!/bin/bash

start (){
sudo pacman -S dialog --needed --noconfirm
menu
}

menu (){
cmd=(dialog --cancel-label "Exit" --title "Menu" --separate-output --checklist "Select options:" 17 70 10)
options=(
1 "Git Clone Alg-Plasma-Pure" on
2 "Remove [chaotic-aur] to alg-plasma-pure/pacman.conf" off
3 "Add [alfonsu_repo] to alg-plasma-pure/pacman.conf" on
4 "Enable [multilib] to alg-plasma-pure/pacman.conf" on
5 "Change SigLevel to Never in alg-plasma-pure/pacman.conf" off
6 "Change iso compression to zstd" on
7 "Change compression to zstd in mkinitcpio" on
8 "Remove [alg_repo] to alg-plasma-pure/airootfs/etc/pacman.conf" off
9 "Add extra packages" on
10 "Create ISO NOW" on
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo pacman -Syyu --noconfirm
sudo pacman -S git archiso --needed --noconfirm
git clone https://github.com/arch-linux-gui/alg-plasma-pure $HOME/alg-plasma-pure/
;;
2)
sed -i '$d' $HOME/alg-plasma-pure/pacman.conf
sed -i '$d' $HOME/alg-plasma-pure/pacman.conf
sed -i '$d' $HOME/alg-plasma-pure/pacman.conf
sed -i '$d' $HOME/alg-plasma-pure/pacman.conf
;;
3)
echo >> $HOME/alg-plasma-pure/pacman.conf
echo [alfonsu_repo] >> $HOME/alg-plasma-pure/pacman.conf
echo SigLevel = Optional TrustedOnly >> $HOME/alg-plasma-pure/pacman.conf
echo Server = https://alfonsu.github.io/\$repo/\$arch >> $HOME/alg-plasma-pure/pacman.conf
;;
4)
sed -i '/#\[multilib\]/{n;s/.*/Include = \/etc\/pacman.d\/mirrorlist/}' $HOME/alg-plasma-pure/pacman.conf
sed -i 's/#\[multilib\]/\[multilib\]/g' $HOME/alg-plasma-pure/pacman.conf
;;
5)
sed -i 's*SigLevel    = Required DatabaseOptional*SigLevel    = Never*g' $HOME/alg-plasma-pure/pacman.conf
;;
6)
sed -i '/#airootfs_image_tool_options=/c\' $HOME/alg-plasma-pure/profiledef.sh
sed -i "/airootfs_image_tool_options=/c\airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '1' '-b' '1M')" $HOME/alg-plasma-pure/profiledef.sh
;;
7)
sed -i '/COMPRESSION="xz"/c\#COMPRESSION="xz"\' $HOME/alg-plasma-pure/airootfs/etc/mkinitcpio.conf
sed -i 's/#COMPRESSION="zstd"/COMPRESSION="zstd"/g' $HOME/alg-plasma-pure/airootfs/etc/mkinitcpio.conf
;;
8)
sed -i '$d' $HOME/alg-plasma-pure/airootfs/etc/pacman.conf
sed -i '$d' $HOME/alg-plasma-pure/airootfs/etc/pacman.conf
sed -i '$d' $HOME/alg-plasma-pure/airootfs/etc/pacman.conf
sed -i '$d' $HOME/alg-plasma-pure/airootfs/etc/pacman.conf
;;
9)
echo gparted >> $HOME/alg-plasma-pure/packages.x86_64
echo qt-fsarchiver >> $HOME/alg-plasma-pure/packages.x86_64
;;
10)
cd $HOME/alg-plasma-pure/
sudo mkarchiso -v .
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
