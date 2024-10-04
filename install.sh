#!/bin/bash

set -e

# install packages
packages=(
    alsa-utils
    bspwm
    brightnessctl
    fcitx5
    fcitx5-mozc
    fish
    fonts-jetbrains-mono
    gnome-themes-extra
    gnome-themes-extra-data
    neovim
    powerline
    rofi
    rxvt-unicode
    sxhkd
    vivaldi-stable
)
sudo apt install wget gpg

# vivaldi repo setting
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor > packages.vivaldi.gpg
sudo install -o root -g root -m 644 packages.vivaldi.gpg /etc/apt/trusted.gpg.d
sudo sh -c 'echo "deb [arch=amd64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.vivaldi.gpg] https://repo.vivaldi.com/archive/deb stable main" > /etc/apt/sources.list.d/vivaldi.list' 
rm -f packages.vivaldi.gpg

# update / upgrade packages
sudo apt update && sudo apt upgrade -y

# install packages
for pkgs in "${packages[@]}"
do
	sudo apt install $pkgs -yqq
done

# fcitx5 settings
echo -e 'GTK_IM_MODULE="fcitx"\nQT_IM_MODULE="fcitx"\nXMODIFIERS=@im=fcitx\nGLFW_IM_MODULE=ibus' | sudo tee /etc/environment

# langage settings
echo -e 'LANGUAGE=ja_JP.UTF-8\nLANG=ja_JP.UTF-8\nLC_ALL=ja_JP.UTF-8' | sudo tee -a /etc/environment

# allow execute brightnessctl without root
sudo chmod +s $(which brightnessctl)

# settings fish
sudo sed -ie s/required/sufficient/g /etc/pam.d/chsh
chsh -s /usr/bin/fish

# copies config
mkdir ~/.config
cp -rf ./config/* ~/.config/
cp -rf ./home/* ~/
cp -rf ./home/.* ~/

