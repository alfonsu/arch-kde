#!/bin/bash

sudo pacman -Sy

#Update mirrorlist to Bulgarian
sudo systemctl stop reflector.service
sudo systemctl disable reflector.service
sudo rm -f /etc/pacman.d/mirrorlist
sudo sh -c 'echo "Server = https://mirrors.uni-plovdiv.net/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist'

#Remove Discover
sudo pacman -Rs discover --noconfirm

#Eenable [multilib]
sudo sed -i '/#\[multilib\]/{n;s/.*/Include = \/etc\/pacman.d\/mirrorlist/}' /etc/pacman.conf
sudo sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf

#Enable [chaotic-aur]
sudo pacman -Sy
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
sudo sh -c 'echo >> /etc/pacman.conf'
sudo sh -c 'echo [chaotic-aur] >> /etc/pacman.conf'
sudo sh -c 'echo Include = /etc/pacman.d/chaotic-mirrorlist >> /etc/pacman.conf'

#Update System
sudo pacman -Syyu --noconfirm

#Update Pamac config
sudo sh -c 'echo RefreshPeriod = 6 >> /etc/pamac.conf'
sudo sh -c 'echo CheckAURUpdates >> /etc/pamac.conf'
sudo sh -c 'echo MaxParallelDownloads = 4 >> /etc/pamac.conf'
sudo sh -c 'echo KeepBuiltPkgs >> /etc/pamac.conf'
sudo sh -c 'echo EnableAUR >> /etc/pamac.conf'
sudo sh -c 'echo KeepNumPackages = 3 >> /etc/pamac.conf'
sudo sh -c 'echo BuildDirectory = /var/tmp >> /etc/pamac.conf'
sudo sh -c 'echo EnableDowngrade >> /etc/pamac.conf'
sudo sh -c 'echo RemoveUnrequiredDeps >> /etc/pamac.conf'

#Install Soft
yes | sudo pacman -S pamac-aur systemdgenie grub-customizer sof-firmware intel-media-driver s-tui libva-utils intel-gpu-tools anydesk-bin encfs --noconfirm
pamac build parsec-bin --no-confirm

#Clean
pamac clean -b --no-confirm
yes | sudo pacman -Scc

#Enable Services
sudo sh -c 'echo "vm.swappiness = 10" >> /etc/sysctl.d/99-swappiness.conf'
sudo systemctl enable systemd-timesyncd.service
sudo systemctl enable bluetooth.service
sudo systemctl enable fstrim.timer

#/etc/mkinit.conf - MODULES=(vmd)
#mkinitcpio -P

echo "----"
echo "Done"
echo "----"
