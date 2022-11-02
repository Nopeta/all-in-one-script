#!/usr/bin/env bash
#use this script need type "chmod u+x *.sh" first and then you run this script

# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
CLEAR='\033[0m'   # Clear color and formatting

# Setup script for setting up a new macos machine
echo -e "${GREEN}Starting Install !${CLEAR}"

# Setup /etc/sudoers for sudo without password prompt
# echo -e "${GREEN}Setup NOPASSWD for %staff ${CLEAR}"
# sudo grep -q '^%staff' /etc/sudoers || sudo sed -i "" 's/^%admin.*/&\n%staff          ALL = (ALL) NOPASSWD: ALL/' /etc/sudoers

install-dev-tools() {
    # sudo apt update
    # sudo apt list --upgradable
    # sudo apt upgrade
    # sudo apt-get update

    ## 設定網路
    cd etc/netplan
    echo '  renderer: NerworkManager' >>00-installer-config.yaml
    netplan apply

    ## spice-vdagent spice-webdavd虛擬機共享目錄與剪貼簿
    echo -e "${YELLOW}Install Spice-vdagent Spice-webdavd${CLEAR}"
    sudo apt install spice-vdagent spice-webdavd

    ## Homebrew
    echo -e "${YELLOW}Install Homebrew${CLEAR}"
    sudo apt install build-essential git

    ## Visual Studio Code
    echo -e "${YELLOW}Install Visual Studio Code${CLEAR}"
    wget -O vscode_arm64.deb https://az764295.vo.msecnd.net/stable/d045a5eda657f4d7b676dedbfa7aab8207f8a075/code_1.72.2-1665612990_arm64.deb
    sudo dpkg -i ./vscode_arm64.deb

    ## UTM
    echo -e "${YELLOW}Install UTM ${CLEAR}"
    brew install --cask utm

    ## Vagrant
    echo -e "${YELLOW}Install Docker & Vagrant${CLEAR}"
    sudo apt install vagrant

    ## iTerm2
    echo -e "${YELLOW}Install iTerm2${CLEAR}"
    brew install iterm2

    ## Appium
    echo -e "${YELLOW}Install Appium${CLEAR}"
    brew install appium

    ## ngrok
    echo -e "${YELLOW}Install ngrok${CLEAR}"
    brew install ngrok

    ## android-studio
    echo -e "${YELLOW}Install android-studio${CLEAR}"
    brew install --cask android-studio

    ## android-platform-tools (for adb usings)
    echo -e "${YELLOW}Install android-platform-tools${CLEAR}"
    brew install homebrew/cask/android-platform-tools

}

install-dev-software() {
    ## Python 3.x
    echo -e "${YELLOW}Install python-3.x${CLEAR}"
    brew install python

    # ## watchman
    # echo -e "${YELLOW}Install watchman ${CLEAR}"
    # brew install watchman

    ## MongoDB
    echo -e "${YELLOW}Install MongoDB ${CLEAR}"
    brew tap mongodb/brew
    brew install mongodb-community@5.0

    ## NVM
    echo -e "${YELLOW}Install NVM${CLEAR}"
    brew install nvm
    mkdir ~/.nvm

    ## Node
    echo -e "${YELLOW}Install Node${CLEAR}"
    nvm install node

    ## nginx
    echo -e "${YELLOW}Install nginx${CLEAR}"
    brew install nginx

    ## git
    echo -e "${YELLOW}Set GIT${CLEAR}"
    git config --global user.email "noiecat128@gmail.com"
    git config --global user.name "Shin"

    ## yarn
    echo -e "${YELLOW}Install yarn${CLEAR}"
    brew install yarn

    ## pnpm
    echo -e "${YELLOW}Install pnpm${CLEAR}"
    brew install pnpm

}

install-basic-tools-brew() {
    ## Google Chrome
    echo -e "${YELLOW}Install Google Chrome${CLEAR}"
    brew install google-chrome

    ## Zoom
    echo -e "${YELLOW}Install Zoom Slack${CLEAR}"
    brew install zoom

    ## Discord
    echo -e "${YELLOW}Install Discord${CLEAR}"
    brew install --cask discord

    ## AnyDesk
    echo -e "${YELLOW}Install AnyDesk${CLEAR}"
    brew install anydesk

}

install-other() {
    ## Numbers
    echo -e "${YELLOW}Install Numbers${CLEAR}"
    mas install 409203825

}

check-by-doctor() {
    echo -e "${GREEN}Checking by Brew Doctor!${CLEAR}"
    dpkg -i
}

php-laravel-packages() {

    ## php
    echo -e "${YELLOW}Install php${CLEAR}"
    brew install php

    ## mysql
    echo -e "${YELLOW}Install mysql${CLEAR}"
    apt-cache search mysql-server

    ## start mysql
    # echo -e "${YELLOW}Starting mysql${CLEAR}"
    # brew services start mysql

    ## composer
    echo -e "${YELLOW}Install composer${CLEAR}"
    brew install composer
    echo '\nexport PATH="$PATH:$HOME/.composer/vendor/bin"' >>~/.zshrc

    ## Laravel 全域安裝
    # echo -e "${YELLOW}Install Laravel${CLEAR}"
    # composer global require "laravel/installer"
}

install-all() {
    echo -e "${GREEN}Starting Install dev-tools !${CLEAR}"
    install-dev-tools

    # echo -e "${GREEN}Starting install dev-software !${CLEAR}"
    # install-dev-software

    # echo -e "${GREEN}Starting Install basic-tools-from-brew !${CLEAR}"
    # install-basic-tools-from-brew

    # echo -e "${GREEN}Starting Install php-laravel-packages !${CLEAR}"
    # php-laravel-packages

    # echo -e "${GREEN}Starting Install Other !${CLEAR}"
    # install-other

    # echo -e "${GREEN}Starting Check !${CLEAR}"
    # check-by-doctor
}

install-all
