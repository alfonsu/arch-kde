#!/bin/bash

echo "Make your Choice"
select yn in "Install Kodi from Flatpak" "Enable Updates for Kodi" "Uninstall All Flatpak Programs"; do
case $yn in
"Install Kodi from Flatpak" )
sudo pacman -S flatpak --needed --noconfirm
flatpak install flathub tv.kodi.Kodi -y
sudo flatpak update --commit=0670d916732866f75a7df4ef50a6e07a3ba05beda445294e90b8df6043bb928a tv.kodi.Kodi -y
flatpak mask tv.kodi.Kodi
rm -rf /$HOME/.var/app/tv.kodi.Kodi/data/
7z x kodi.7z -o$HOME
sed -i "s/pc/$USER/g" $HOME/.var/app/tv.kodi.Kodi/data/userdata/addon_data/pvr.iptvsimple/settings.xml
sed -i "s/90/180/g" $HOME/.var/app/tv.kodi.Kodi/data/userdata/addon_data/plugin.program.bscfusion/settings.xml
sed -i "s/90/180/g" $HOME/.var/app/tv.kodi.Kodi/data/addons/plugin.program.bscfusion/resources/settings.xml
echo "----"
echo "Done"
echo "----"
exit;;
"Enable Updates for Kodi" )
flatpak --remove mask tv.kodi.Kodi
echo "----"
echo "Done"
echo "----"
exit;;
"Uninstall All Flatpak Programs" )
flatpak uninstall --all -y
rm -rf /$HOME/.var
echo "----"
echo "Done"
echo "----"
exit;;
esac
done
