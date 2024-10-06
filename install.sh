#!/bin/bash

set -e

# install packages
packages=(
    alacritty
    alsa-utils
    brightnessctl
    brave-browser
    bspwm
    fcitx
    fcitx-mozc
    fish
    fonts-noto-cjk
    fonts-jetbrains-mono
    gnome-themes-extra
    gnome-themes-extra-data
    lxappearance
    neovim
    numix-icon-theme-circle
    pavucontrol
    pipewire
    powerline
    qt5-gtk2-platformtheme
    qt5ct
    rofi
    sxhkd
    thunar
    xbattbar
    xinit
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

# langage settings
echo -e 'LANGUAGE=ja_JP.UTF-8\nLANG=ja_JP.UTF-8\nLC_ALL=ja_JP.UTF-8' | sudo tee -a /etc/environment

# fcitx settings
echo -e 'GTK_IM_MODULE="fcitx"\nQT_IM_MODULE="fcitx"\nXMODIFIERS=@im=fcitx\nGLFW_IM_MODULE=ibus' | sudo tee -a /etc/environment

# qt5ct settings
echo -e 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment

# settings fish
sudo usermod -s /usr/bin/fish $(whoami)

# settings brightnessctl
sudo chmod +s $(which brightnessctl)

# copies config
mkdir -p ~/.config
cp -rf ./config/* ~/.config/
cp -rf ./home/.* ~/
