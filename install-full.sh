#!/bin/bash

start (){
sudo pacman -S dialog --needed --noconfirm
#dialog --msgbox "Done" 5 10
menu
}

menu (){
cmd=(dialog --cancel-label "Exit" --title "Menu" --menu "Select options:" 40 70 35 )
options=(
1 "Setup Plasma Pure"
2 "HW-Acceleration"
3 "Extra Soft"
4 "Bluetooth"
5 "Gaming"
6 "Fixes"
7 "Clean"
8 "Reboot"
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
setup
;;
2)
hw-acceleration
;;
3)
extra-soft
;;
4)
bluetooth
;;
5)
gaming
;;
6)
fixes
;;
7)
pamac clean -b --no-confirm
yes | sudo pacman -Scc
yes | yay -Scc
menu
;;
8)
reboot
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

setup (){
cmd=(dialog --cancel-label "Back" --title "Setup Plasma Pure" --separate-output --checklist "Select options:" 41 70 35)
options=(
1 "Bypass Sudo Password" on
2 "Remove Discover" on
3 "Bulgarian Mirrorlist" on
4 "Zstd in mkinitcpio" on
5 "Enable [multilib]" on
6 "Add [alg_repo]" off
7 "Add [alg-settings]" off
8 "Add [alfonsu_repo]" on
9 "Add [chaotic-aur]" on
10 "Update System" on
11 "Install Basic KDE Apps and Multimedia Programs" on
12 "Install Extra Programs for Alfonsu" off
13 "Install Libreoffice-Fresh and MS-Fonts" off
14 "Install Flatpak" off
15 "Install Pamac and Yay" on
16 "Update Pamac config" on
17 "Speed up AUR builds" on
18 "Install Youtubedl-GUI" on
19 "Update KDE Configs with Apps" on
20 "Change SDDM Theme to Breeze" on
21 "Add Virtual Keyboard to SDDM" on
22 "Change Swappiness to 10" on
23 "Enable Timesync and Bluetooth Service" on
24 "Enable Fstrim (for SSD optimization)" on
25 "Disable Spectre and Meltdown" on
26 "Enable Grub Last Choice (Not Work for Btrfs)" on
27 "Enable Vimix Grub Theme" on
28 "Install Nohang - correctly prevent out of memory" on
29 "Install and Enable Zram-Generator" off
30 "Install Ananicy - manage processes IO and CPU priorities" off
31 "Install and Enable Printer and Scanner Support" off
32 "Auto Mount All NTFS Partitions to fstab" off
33 "Install Latest Zen Kernel and Headers" off
34 "Update Grub" on
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo sh -c 'echo >> /etc/sudoers'
sudo sh -c 'echo "## Skip password prompt for current user" >> /etc/sudoers'
sudo sh -c 'echo "Defaults:pc !authenticate" >> /etc/sudoers'
sudo sed -i "s/pc/$USER/g" /etc/sudoers
sudo sh -c 'echo >> /etc/sudoers'
sudo sh -c 'echo "## Set nano as default editor" >> /etc/sudoers'
sudo sh -c 'echo "Defaults env_reset" >> /etc/sudoers'
sudo sh -c 'echo "Defaults editor=/usr/bin/nano, !env_editor" >> /etc/sudoers'
sudo sh -c 'echo "/* Allow members of the wheel group to execute any actions" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo " * without password authentication, similar to \"sudo NOPASSWD:\"" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo " */" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo "polkit.addRule(function(action, subject) {" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo "    if (subject.isInGroup(\"wheel\")) {" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo "        return polkit.Result.YES;" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo "    }" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo "});" >> /etc/polkit-1/rules.d/49-nopasswd_global.rules'
sudo sh -c 'echo "KDE_FULL_SESSION=true" >> /etc/environment'
sudo sh -c 'echo "KDE_SESSION_VERSION=5" >> /etc/environment'
echo "[super-user-command]" >> $HOME/.config/kdesurc
echo "super-user-command=sudo" >> $HOME/.config/kdesurc
;;
2)
sudo pacman -Rs discover --noconfirm
;;
3)
sudo systemctl stop reflector.service
sudo systemctl disable reflector.service
sudo rm -f /etc/pacman.d/mirrorlist
sudo sh -c 'echo "Server = https://mirrors.uni-plovdiv.net/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist'
;;
4)
sudo sed -i '/COMPRESSION="xz"/c\#COMPRESSION="xz"\' /etc/mkinitcpio.conf
sudo sed -i 's/#COMPRESSION="zstd"/COMPRESSION="zstd"/g' /etc/mkinitcpio.conf
;;
5)
sudo sed -i '/#\[multilib\]/{n;s/.*/Include = \/etc\/pacman.d\/mirrorlist/}' /etc/pacman.conf
sudo sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
;;
6)
sudo sh -c 'echo >> /etc/pacman.conf'
sudo sh -c 'echo [alg_repo] >> /etc/pacman.conf'
sudo sh -c 'echo SigLevel = Optional TrustedOnly >> /etc/pacman.conf'
sudo sh -c 'echo Server = https://arch-linux-gui.github.io/\$repo/\$arch >> /etc/pacman.conf'
;;
7)
sudo sh -c 'echo >> /etc/pacman.conf'
sudo sh -c 'echo [alg-settings] >> /etc/pacman.conf'
sudo sh -c 'echo SigLevel = Optional TrustedOnly >> /etc/pacman.conf'
sudo sh -c 'echo Server = https://arch-linux-gui.github.io/\$repo/\$arch >> /etc/pacman.conf'
;;
8)
sudo sh -c 'echo >> /etc/pacman.conf'
sudo sh -c 'echo [alfonsu_repo] >> /etc/pacman.conf'
sudo sh -c 'echo SigLevel = Optional TrustedOnly >> /etc/pacman.conf'
sudo sh -c 'echo Server = https://alfonsu.github.io/\$repo/\$arch >> /etc/pacman.conf'
;;
9)
sudo pacman -Syy
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
sudo sh -c 'echo >> /etc/pacman.conf'
sudo sh -c 'echo [chaotic-aur] >> /etc/pacman.conf'
sudo sh -c 'echo Include = /etc/pacman.d/chaotic-mirrorlist >> /etc/pacman.conf'
sudo sh -c 'echo >> /etc/pacman.conf'
;;
10)
sudo pacman -Syyu --noconfirm
;;
11)
sudo pacman -S ark p7zip unrar unarchiver gwenview okular filelight ffmpegthumbs chromium qbittorrent audacious vlc guvcview gparted gpart exfatprogs gnome-calculator icoutils systemdgenie grub-customizer imwheel onboard encfs kdeconnect --needed --noconfirm
;;
12)
sudo pacman -S htop ksysguard kompare gimp filezilla ferdi telegram-desktop gnome-keyring skypeforlinux-stable-bin teamviewer anydesk-bin obs-studio qmplay2 --needed --noconfirm
sudo systemctl enable teamviewerd
sudo systemctl start teamviewerd
;;
13)
sudo pacman -S ttf-ms-fonts libreoffice-fresh libreoffice-fresh-bg --needed --noconfirm
;;
14)
sudo pacman -S flatpak --needed --noconfirm
;;
15)
yes | sudo pacman -S pamac-aur pamac-tray-icon-plasma yay update-grub downgrade
;;
16)
sudo sed -i 's/#RemoveUnrequiredDeps/RemoveUnrequiredDeps/g' /etc/pamac.conf
sudo sed -i 's/#EnableAUR/EnableAUR/g' /etc/pamac.conf
sudo sed -i 's/#KeepBuiltPkgs/KeepBuiltPkgs/g' /etc/pamac.conf
sudo sed -i 's/#CheckAURUpdates/CheckAURUpdates/g' /etc/pamac.conf
;;
17)
sudo sed -i 's,#MAKEFLAGS="-j2",MAKEFLAGS="-j$(nproc)",g' /etc/makepkg.conf
;;
18)
sudo pacman -S yt-dlp-drop-in --needed --noconfirm
sudo pacman -S youtubedl-gui --needed --noconfirm
;;
19)
tar xf simple.tar.gz -C $HOME
;;
20)
sudo rm -f /etc/sddm.conf
sudo rm -f /etc/sddm.conf.d/kde_settings.conf
sudo rm -f /etc/sddm.conf.d/virtualkeyboard.conf
sudo sh -c 'echo [Autologin] >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo Relogin=false >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo Session=plasma >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo User=pc >> /etc/sddm.conf.d/kde_settings.conf'
sudo sed -i "s/pc/$USER/g" /etc/sddm.conf.d/kde_settings.conf
sudo sh -c 'echo >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo [General] >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo HaltCommand=/usr/bin/systemctl poweroff >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo RebootCommand=/usr/bin/systemctl reboot >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo [Theme] >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo Current=breeze >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo [Users] >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo MaximumUid=60513 >> /etc/sddm.conf.d/kde_settings.conf'
sudo sh -c 'echo MinimumUid=1000 >> /etc/sddm.conf.d/kde_settings.conf'
;;
21)
sudo pacman -S qt5-virtualkeyboard --needed --noconfirm
sudo sh -c 'echo InputMethod=qtvirtualkeyboard >> /etc/sddm.conf.d/virtualkeyboard.conf'
;;
22)
sudo sh -c 'echo "vm.swappiness = 10" >> /etc/sysctl.d/99-swappiness.conf'
;;
23)
sudo systemctl enable systemd-timesyncd.service
sudo systemctl enable bluetooth.service
;;
24)
sudo systemctl enable fstrim.timer
;;
25)
sudo sed -i 's/quiet/mitigations=off quiet/g' /etc/default/grub
;;
26)
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
sudo sed -i 's/#GRUB_SAVEDEFAULT="true"/GRUB_SAVEDEFAULT="true"/g' /etc/default/grub
;;
27)
sudo pacman -S grub-theme-vimix --needed --noconfirm
sudo sed -i '/GRUB_THEME=/c\GRUB_THEME=/usr/share/grub/themes/Vimix/theme.txt\' /etc/default/grub
;;
28)
sudo pacman -S nohang --needed --noconfirm
sudo systemctl enable --now nohang-desktop.service
;;
29)
sudo pacman -S zram-generator --needed --noconfirm
sudo sh -c 'echo "[zram0]" >> /etc/systemd/zram-generator.conf'
sudo sh -c 'echo "zram-size = 16384" >> /etc/systemd/zram-generator.conf'
;;
30)
sudo pacman -S ananicy --needed --noconfirm
sudo systemctl enable ananicy
sudo systemctl start ananicy
;;
31)
sudo pacman -S cups print-manager system-config-printer skanlite --needed --noconfirm
sudo systemctl enable cups.service
sudo systemctl start cups.service
;;
32)
echo "--------------------------------------"
echo "Remove All USB Devices Before Continue"
echo "--------------------------------------"
sudo mkdir /media
sudo bash diskmounter.sh
sudo sed -i 's/ntfs rw,user,fmask=0111,dmask=0000 0 0/ntfs-3g defaults,auto,uid=1000,gid=1000,umask=002 0 0/g' /etc/fstab
;;
33)
sudo pacman -S linux-zen linux-zen-headers --needed --noconfirm
;;
34)
sudo grub-mkconfig -o /boot/grub/grub.cfg
;;
esac
done
case "$ret" in
*) menu ;;
esac
}

hw-acceleration (){
cmd=(dialog --cancel-label "Back" --title "HW-Acceleration" --menu "Select options:" 40 70 35)
options=(
1 "Intel"
2 "AMD"
3 "Nvidia"
4 "Translation Layers"
5 "Chromium Settings"
6 "Chrome Settings"
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
intel
;;
2)
amd
;;
3)
nvidia
;;
4)
layers
;;
5)
chromium
;;
6)
chrome
;;
esac
done
case "$ret" in
*) menu ;;
esac
}

intel (){
cmd=(dialog --cancel-label "Back" --title "HW-Acceleration" --menu "Select options:" 40 70 35)
options=(
1 "VA-API on Intel GPUs 2008-2016"
2 "VA-API on Intel GPUs 2017+"
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo pacman -S libva-intel-driver libva-utils intel-gpu-tools --needed --noconfirm
;;
2)
sudo pacman -S intel-media-driver libva-utils intel-gpu-tools --needed --noconfirm
;;
esac
done
case "$ret" in
*) hw-acceleration;;
esac
}

amd (){
cmd=(dialog --cancel-label "Back" --title "HW-Acceleration" --menu "Select options:" 40 70 35)
options=(
1 "VA-API on Radeon HD 2000 and newer GPUs"
2 "VDPAU on Radeon R300 and newer GPUs"
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo pacman -S libva-mesa-driver libva-utils radeontop --needed --noconfirm
;;
2)
sudo pacman -S mesa-vdpau vdpauinfo radeontop --needed --noconfirm
;;
esac
done
case "$ret" in
*) hw-acceleration;;
esac
}

nvidia (){
cmd=(dialog --cancel-label "Back" --title "HW-Acceleration" --menu "Select options:" 40 70 35)
options=(
1 "NVIDIA Latest Drivers for Latest Arch Linux Kernel"
2 "NVIDIA Latest Drivers for Latest Arch Linux-LTS Kernel"
3 "NVIDIA Latest Drivers for Other Kernels (need headers)"
4 "NVIDIA 470xx Drivers for All Kernels (need headers)"
5 "NVIDIA 390xx Drivers for All Kernels (need headers)"
6 "NVIDIA 340xx Drivers for All Kernels (need headers)"
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo pacman -S nvidia nvidia-settings opencl-nvidia pkg-config --needed --noconfirm
;;
2)
sudo pacman -S nvidia-lts nvidia-settings opencl-nvidia pkg-config --needed --noconfirm
;;
3)
sudo pacman -S nvidia-dkms nvidia-settings opencl-nvidia pkg-config --needed --noconfirm
;;
4)
sudo pacman -S nvidia-470xx-dkms nvidia-470xx-settings opencl-nvidia-470xx pkg-config --needed --noconfirm
;;
5)
sudo pacman -S nvidia-390xx-dkms nvidia-390xx-settings opencl-nvidia-390xx pkg-config --needed --noconfirm
;;
6)
sudo pacman -S pkg-config --needed --noconfirm
pamac build nvidia-340xx-dkms --no-confirm
pamac build nvidia-340xx-settings --no-confirm
pamac build opencl-nvidia-340xx --no-confirm
sudo sh -c 'echo "Section \"ServerFlags\"" >> /etc/X11/xorg.conf.d/20-nvidia.conf'
sudo sh -c 'echo "Option \"IgnoreABI\" \"1\"" >> /etc/X11/xorg.conf.d/20-nvidia.conf'
sudo sh -c 'echo "EndSection" >> /etc/X11/xorg.conf.d/20-nvidia.conf'
;;
esac
done
case "$ret" in
*) hw-acceleration;;
esac
}

layers (){
cmd=(dialog --cancel-label "Back" --title "HW-Acceleration" --menu "Select options:" 40 70 35)
options=(
1 "VDPAU-based backend for VA-API"
2 "VDPAU-based backend for VA-API VP9"
3 "VDPAU-based backend for VA-API Chromium"
4 "VDPAU driver with OpenGL/VAAPI backend. H.264 only"
5 "CUDA NVDECODE based backend for VA-API"
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
yes | sudo pacman -S libva-vdpau-driver
;;
2)
pamac build libva-vdpau-driver-vp9-git --no-confirm
;;
3)
pamac build libva-vdpau-driver-chromium --no-confirm
;;
4)
yes | sudo pacman -S libvdpau-va-gl --needed --noconfirm
;;
5)
pamac build libva-nvidia-driver --no-confirm
;;
esac
done
case "$ret" in
*) hw-acceleration;;
esac
}

chromium (){
cmd=(dialog --cancel-label "Back" --title "HW-Acceleration-Chromium" --separate-output --checklist "Select options:" 40 70 35)
options=(
1 "Remove Previous Settings" on
2 "--ignore-gpu-blocklist" on
3 "--enable-gpu-rasterization" on
4 "--enable-zero-copy" on
5 "--enable-features=VaapiVideoDecoder" on
6 "--disable-features=UseChromeOSDirectVideoDecoder" on
7 "--use-gl=desktop" off
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
rm -f $HOME/.config/chromium-flags.conf
;;
2)
echo --ignore-gpu-blocklist >> $HOME/.config/chromium-flags.conf
;;
3)
echo --enable-gpu-rasterization >> $HOME/.config/chromium-flags.conf
;;
4)
echo --enable-zero-copy >> $HOME/.config/chromium-flags.conf
;;
5)
echo --enable-features=VaapiVideoDecoder >> $HOME/.config/chromium-flags.conf
;;
6)
echo --disable-features=UseChromeOSDirectVideoDecoder >> $HOME/.config/chromium-flags.conf
;;
7)
echo --use-gl=desktop >> $HOME/.config/chromium-flags.conf
;;
esac
done
case "$ret" in
*) hw-acceleration ;;
esac
}

chrome (){
cmd=(dialog --cancel-label "Back" --title "HW-Acceleration-Chrome" --separate-output --checklist "Select options:" 40 70 35)
options=(
1 "Remove Previous Settings" on
2 "--ignore-gpu-blocklist" on
3 "--enable-gpu-rasterization" on
4 "--enable-zero-copy" on
5 "--enable-features=VaapiVideoDecoder" on
6 "--disable-features=UseChromeOSDirectVideoDecoder" on
7 "--use-gl=desktop" off
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
rm -f $HOME/.config/chrome-flags.conf
;;
2)
echo --ignore-gpu-blocklist >> $HOME/.config/chrome-flags.conf
;;
3)
echo --enable-gpu-rasterization >> $HOME/.config/chrome-flags.conf
;;
4)
echo --enable-zero-copy >> $HOME/.config/chrome-flags.conf
;;
5)
echo --enable-features=VaapiVideoDecoder >> $HOME/.config/chrome-flags.conf
;;
6)
echo --disable-features=UseChromeOSDirectVideoDecoder >> $HOME/.config/chrome-flags.conf
;;
7)
echo --use-gl=desktop >> $HOME/.config/chrome-flags.conf
;;
esac
done
case "$ret" in
*) hw-acceleration ;;
esac
}

bluetooth (){
cmd=(dialog --cancel-label "Back" --title "Bluetooth" --menu "Select options:" 40 70 35)
options=(
1 "Headset via Pipewire"
2 "Headset via Bluez5/PulseAudio"
3 "CSR Dongle 0a12:0001"
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
Headset-via-Pipewire
;;
2)
Headset-via-Bluez5/PulseAudio
;;
3)
CSR-Dongle-0a12:0001
;;
esac
done
case "$ret" in
*) menu;;
esac
}

Headset-via-Pipewire (){
cmd=(dialog --cancel-label "Back" --title "Headset via Pipewire" --separate-output --checklist "Select options:" 40 70 35)
options=(
1 "Install Headset via Pipewire" on
2 "Enable Bluetooth Battery Level Reporting" on
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
yes | sudo pacman -S pipewire-pulse
;;
2)
sudo sed -i 's/#Experimental = false/Experimental = true/g' /etc/bluetooth/main.conf
;;
esac
done
case "$ret" in
*) bluetooth ;;
esac
}

Headset-via-Bluez5/PulseAudio (){
cmd=(dialog --cancel-label "Back" --title "Headset via Bluez5/PulseAudio" --separate-output --checklist "Select options:" 40 70 35)
options=(
1 "Install Headset via Bluez5/PulseAudio" on
2 "Enable Bluetooth Autoconnect" on
3 "Enable Bluetooth Battery Level Reporting" on
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
yes | sudo pacman -S pulseaudio-alsa pulseaudio-bluetooth bluez-utils
;;
2)
sudo pacman -S bluetooth-autoconnect --needed --noconfirm
sudo systemctl enable bluetooth-autoconnect
systemctl --user enable pulseaudio-bluetooth-autoconnect
;;
3)
sudo sed -i 's/#Experimental = false/Experimental = true/g' /etc/bluetooth/main.conf
;;
esac
done
case "$ret" in
*) bluetooth ;;
esac
}

CSR-Dongle-0a12:0001 (){
cmd=(dialog --cancel-label "Back" --title "CSR Dongle 0a12:0001" --separate-output --checklist "Select options:" 40 70 35)
options=(
1 "Fix CSR Dongle 0a12:0001" on
2 "Install Linux-LTS-5.10" on
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo rm -f /etc/modprobe.d/csr-bluetoothdongle.conf
sudo sh -c 'echo "options btusb reset=1 enable_autosuspend=0" >> /etc/modprobe.d/csr-bluetoothdongle.conf'
;;
2)
sudo pacman -S wget --needed --noconfirm
wget https://archive.archlinux.org/packages/l/linux-lts/linux-lts-5.10.90-1-x86_64.pkg.tar.zst
wget https://archive.archlinux.org/packages/l/linux-lts-headers/linux-lts-headers-5.10.90-1-x86_64.pkg.tar.zst
sudo pacman -U linux-lts-5.10.90-1-x86_64.pkg.tar.zst --needed --noconfirm
sudo pacman -U linux-lts-headers-5.10.90-1-x86_64.pkg.tar.zst --needed --noconfirm
rm linux-lts-5.10.90-1-x86_64.pkg.tar.zst
rm linux-lts-headers-5.10.90-1-x86_64.pkg.tar.zst
sudo grub-mkconfig -o /boot/grub/grub.cfg
;;
esac
done
case "$ret" in
*) bluetooth ;;
esac
}

gaming (){
cmd=(dialog --cancel-label "Back" --title "Gaming" --separate-output --checklist "Select options:" 40 70 35)
options=(
1 "Install Wine" on
2 "Install PlayOnLinux" off
3 "Install Bottles" off
4 "Install Lutris" off
5 "Configure Ulimit to use Esync in Wine" off
6 "Install DXVK for Nvidia Latest Drivers" off
7 "Install DXVK for AMD" off
8 "Install DXVK for Intel" off
9 "Install GameMode" off
10 "Install MangoHud" off
11 "Install GOverlay" off
12 "Install Steam" off
13 "Install ProtonUp-Qt" off
14 "Install Libstrangle (Simple FPS Limiter)" off
15 "Install NoiseTorch (Microphone Noise Cancelling)" off
16 "Install Heroic Games Launcher (Epic Games Store)" off
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo pacman -S wine wine-gecko wine-mono winetricks wine-installer --needed --noconfirm
;;
2)
sudo pacman -S playonlinux --needed --noconfirm
;;
3)
sudo pacman -S bottles --needed --noconfirm
;;
4)
sudo pacman -S lutris --needed --noconfirm
;;
5)
sudo sh -c 'echo "DefaultLimitNOFILE=1048576" >> /etc/systemd/user.conf'
sudo sh -c 'echo "DefaultLimitNOFILE=1048576" >> /etc/systemd/system.conf'
sudo sh -c 'echo "* hard nofile 1048576" >> /etc/security/limits.conf'
;;
6)
sudo pacman -S lib32-nvidia-utils vulkan-icd-loader vulkan-tools --needed --noconfirm
;;
7)
sudo pacman -S vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader vulkan-tools --needed --noconfirm
;;
8)
sudo pacman -S vulkan-intel lib32-vulkan-intel vulkan-icd-loader vulkan-tools --needed --noconfirm
;;
9)
sudo pacman -S gamemode lib32-gamemode --needed --noconfirm
;;
10)
sudo pacman -S mangohud-git lib32-mangohud-git --needed --noconfirm
;;
11)
sudo pacman -S goverlay-git --needed --noconfirm
;;
12)
sudo pacman -S steam --needed --noconfirm
;;
13)
sudo pacman -S protonup-qt --needed --noconfirm
;;
14)
sudo pacman -S libstrangle-git --needed --noconfirm
;;
15)
sudo pacman -S noisetorch --needed --noconfirm
;;
16)
sudo pacman -S heroic-games-launcher-bin --needed --noconfirm
;;
esac
done
case "$ret" in
*) menu ;;
esac
}

extra-soft (){
cmd=(dialog --cancel-label "Back" --title "Extra Soft" --separate-output --checklist "Select options:" 40 70 35)
options=(
1 "Install VirtualBox for Latest Arch Linux Kernel" off
2 "Install VirtualBox for Others Kernels (need headers)" off
3 "Install CDemu for Latest Zen Kernel" off
4 "Install CDemu for Others Kernels (need headers)" off
5 "Install Anbox for Latest Zen Kernel" off
6 "Install SVP (Smooth Video Project)" off
7 "Install Minitube with (mpv-git)" off
8 "Install TeamViewer" off
9 "Install Skype" off
10 "Install MEGA" off
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso virtualbox-ext-oracle --needed --noconfirm
sudo modprobe vboxdrv
sudo gpasswd -a $USER vboxusers
;;
2)
sudo pacman -S virtualbox virtualbox-host-dkms virtualbox-guest-iso virtualbox-ext-oracle --needed --noconfirm
sudo modprobe vboxdrv
sudo gpasswd -a $USER vboxusers
;;
3)
sudo pacman -S kde-cdemu-manager --needed --noconfirm
sed -i 's/mountisoaction=true/mountisoaction=false/g' $HOME/.config/kservicemenurc
;;
4)
sudo pacman -S kde-cdemu-manager vhba-module-dkms --needed --noconfirm
sed -i 's/mountisoaction=true/mountisoaction=false/g' $HOME/.config/kservicemenurc
;;
5)
sudo pacman -S anbox-support --needed --noconfirm
;;
6)
#pamac build svp --no-confirm
#pamac build mpv-git --no-confirm
sudo pacman -S svp --needed --noconfirm
sudo pacman -S mpv-git --needed --noconfirm
sudo pacman -S ocl-icd --needed --noconfirm
rm -rf $HOME/.config/mpv/
mkdir $HOME/.config/mpv/
echo profile=svp >> $HOME/.config/mpv/mpv.conf
echo autofit-larger=100%x100% >> $HOME/.config/mpv/mpv.conf
echo [svp] >> $HOME/.config/mpv/mpv.conf
echo input-ipc-server=/tmp/mpvsocket >> $HOME/.config/mpv/mpv.conf
echo hr-seek-framedrop=no >> $HOME/.config/mpv/mpv.conf
echo resume-playback=no >> $HOME/.config/mpv/mpv.conf
echo hwdec=auto-copy >> $HOME/.config/mpv/mpv.conf
echo hwdec-codecs=all >> $HOME/.config/mpv/mpv.conf
echo '#opengl-early-flush=yes' >> $HOME/.config/mpv/mpv.conf
;;
7)
sudo pacman -S mpv-git --needed --noconfirm
sudo cp /usr/lib/libmpv.so /usr/lib/libmpv.so.1
sudo pacman -S minitube-mpv-git --needed --noconfirm
;;
8)
sudo pacman -S teamviewer --needed --noconfirm
sudo systemctl enable teamviewerd
sudo systemctl start teamviewerd
;;
9)
sudo pacman -S gnome-keyring skypeforlinux-stable-bin --needed --noconfirm
;;
10)
sudo pacman -S wget --needed --noconfirm
wget https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst
wget https://mega.nz/linux/repo/Arch_Extra/x86_64/dolphin-megasync-x86_64.pkg.tar.xz
sudo pacman -U megasync-x86_64.pkg.tar.zst --needed --noconfirm
sudo pacman -U dolphin-megasync-x86_64.pkg.tar.xz --needed --noconfirm
rm megasync-x86_64.pkg.tar.zst
rm dolphin-megasync-x86_64.pkg.tar.xz
sudo pacman -Syy
;;
esac
done
case "$ret" in
*) menu ;;
esac
}

fixes (){
cmd=(dialog --cancel-label "Back" --title "Fixes" --menu "Select options:" 40 70 35)
options=(
1 "Sound-Fix (use if primary output channel is not correctly)"
2 "USB-wakeup (use if usb wake up not working)"
3 "Imwheel-Fix (use if imwheel cant startup)"
4 "Enable Nvidia Overclock (nvidia-xconfig --cool-bits=12)"
5 "Enable Nvidia DRM (needed for wayland support)"
        )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
case $choice in
1)
sudo sh -c 'echo "set-sink-port 0 analog-output-lineout" >> /etc/pulse/default.pa'
;;
2)
sudo rm -f /etc/rc.d/rc.local
sudo mkdir /etc/rc.d/
sudo sh -c 'echo "#!/bin/bash" >> /etc/rc.d/rc.local'
sudo sh -c 'grep . /sys/bus/usb/devices/*/power/wakeup >> /etc/rc.d/rc.local'
sudo sed -i 's/:enabled//g' /etc/rc.d/rc.local
sudo sed -i 's/:disabled//g' /etc/rc.d/rc.local
sudo sed -i 's*/sys/*echo enabled > /sys/*g' /etc/rc.d/rc.local
sudo sh -c 'echo "exit 0" >> /etc/rc.d/rc.local'
sudo chmod u+x /etc/rc.d/rc.local
sudo rm -f /etc/systemd/system/rc-local.service
sudo sh -c 'echo [Unit] >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo Description=/etc/rc.local compatibility >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo ConditionFileIsExecutable=/etc/rc.d/rc.local >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo [Service] >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo Type=oneshot >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo ExecStart=/etc/rc.d/rc.local >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo TimeoutSec=0 >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo StandardOutput=tty >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo RemainAfterExit=yes >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo SysVStartPriority=99 >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo [Install] >> /etc/systemd/system/rc-local.service'
sudo sh -c 'echo WantedBy=multi-user.target >> /etc/systemd/system/rc-local.service'
sudo systemctl enable rc-local.service
;;
3)
sudo sh -c 'echo "#!/bin/sh" >> /etc/profile.d/startup.sh'
sudo sh -c 'echo "imwheel -b 45" >> /etc/profile.d/startup.sh'
;;
4)
sudo nvidia-xconfig --cool-bits=12
;;
5)
sudo sed -i 's/quiet/nvidia-drm.modeset=1 quiet/g' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
;;
esac
done
case "$ret" in
*) menu;;
esac
}

start
