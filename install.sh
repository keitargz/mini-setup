#!/bin/bash

set -e

# install packages
packages=(
    alsa-utils
    brave-browser
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
)

# install brave
sudo apt install curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

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

