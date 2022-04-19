#!/bin/bash

#sudo pacman -S archlinux-keyring

#sudo rm -r /etc/pacman.d/gnupg/
sudo pacman-key --init
sudo pacman-key --populate archlinux

echo "----"
echo "Done"
echo "----"
