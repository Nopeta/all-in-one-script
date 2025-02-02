#!/usr/bin/env bash

# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
CLEAR='\033[0m'   # Clear color and formatting

# Setup script for setting up a new macos machine
echo -e "${GREEN}Starting Install !${CLEAR}"

# Setup /etc/sudoers for sudo without password prompt
echo -e "${GREEN}Setup NOPASSWD for %staff ${CLEAR}"
sudo grep -q '^%staff' /etc/sudoers || sudo sed -i "" 's/^%admin.*/&\n%staff          ALL = (ALL) NOPASSWD: ALL/' /etc/sudoers

install-dev-tools() {

    # Command Line Tools for Xcode
    echo "Install command line developer tools"
    xcode-select --install
    xcode-select -p &>/dev/null
    if [ $? -ne 0 ]; then
        echo "Xcode CLI tools not found. Installing them..."
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
        PROD=$(softwareupdate -l |
            grep "\*.*Command Line" |
            head -n 1 | awk -F"*" '{print $2}' |
            sed -e 's/^ *//' |
            tr -d '\n')
        softwareupdate -i "$PROD" -v
    else
        echo "Xcode CLI tools OK"
    fi

    ## Homebrew
    echo -e "${YELLOW}Install Homebrew${CLEAR}"
    CI=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew update

    ## Visual Studio Code
    echo -e "${YELLOW}Install Visual Studio Code${CLEAR}"
    brew install visual-studio-code

    ## mas-cli
    ## A simple command line interface for the Mac App Store. Designed for scripting and automation.
    echo -e "${YELLOW}Install mas-cli${CLEAR}"
    brew install mas

    ## UTM
    echo -e "${YELLOW}Install UTM ${CLEAR}"
    brew install --cask utm

    ## Docker, Vagrant
    echo -e "${YELLOW}Install Docker & Vagrant${CLEAR}"
    brew install docker vagrant

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
    touch ~/.zshrc
    sudo grep -q '^local' ~/.zshrc || echo 'local brew_path="/opt/homebrew/bin" \nlocal brew_opt_path="/opt/homebrew/opt" \nlocal nvm_path="$HOME/.nvm" \n\nexport PATH="${brew_path}:${PATH}"\nexport NMV_DIR="$HOME/.nvm" \n\n[ -s "${brew_opt_path}/nvm/nvm.sh" ] && . "${brew_opt_path}/nvm/nvm.sh"\n[ -s "${brew_opt_path}/nvm/etc/bash_completion.d/nvm" ] && . "${brew_opt_path}/nvm/etc/bash_completion.d/nvm"' >>~/.zshrc

    ## Node
    echo -e "${YELLOW}Install Node${CLEAR}"
    nvm install node

    ## nginx
    echo -e "${YELLOW}Install nginx${CLEAR}"
    brew install nginx

    ## git
    echo -e "${YELLOW}Install GIT${CLEAR}"
    brew install git
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

    ## Edge
    echo -e "${YELLOW}Install Edge${CLEAR}"
    brew install --cask microsoft-edge

    ## Zoom
    echo -e "${YELLOW}Install Zoom Slack${CLEAR}"
    brew install zoom

    ## nano
    echo -e "${YELLOW}Install nano${CLEAR}"
    brew install nano

    ## AltTab 視窗切換
    echo -e "${YELLOW}Install AltTab${CLEAR}"
    brew install --cask alt-tab

    ## itsycal 小日曆
    echo -e "${YELLOW}Install Itsycal ${CLEAR}"
    brew install --cask itsycal

    ## rectangle 畫面分割
    echo -e "${YELLOW}Install Rectangle ${CLEAR}"
    brew install --cask rectangle

    ## MonitorControl 多螢幕亮度分開調整
    echo -e "${YELLOW}Install MonitorControl ${CLEAR}"
    brew install --cask monitorcontrol

    ## hiddenbar
    echo -e "${YELLOW}Install hiddenbar ${CLEAR}"
    brew install --cask hiddenbar

    # ## Clipy 剪貼簿（純文字）
    # echo -e "${YELLOW}Install Clipy ${CLEAR}"
    # brew install --cask clipy

    ## Maccy 剪貼簿（可以有圖）
    echo -e "${YELLOW}Install Maccy ${CLEAR}"
    brew install --cask maccy

    ## karabiner-elements 鍵盤改鍵（外接鍵盤用）
    echo -e "${YELLOW}Install Karabiner-Elements ${CLEAR}"
    brew install --cask karabiner-elements

    ## Discord
    echo -e "${YELLOW}Install Discord${CLEAR}"
    brew install --cask discord

    ## AnyDesk
    echo -e "${YELLOW}Install AnyDesk${CLEAR}"
    brew install anydesk

    ## Appcleaner
    echo -e "${YELLOW}Install Appcleaner${CLEAR}"
    brew install --cask appcleaner

    ## Keka 解壓縮
    echo -e "${YELLOW}Install Keka${CLEAR}"
    brew install --cask keka

    ## CheatSheet
    echo -e "${YELLOW}Install CheatSheet${CLEAR}"
    brew install --cask cheatsheet

}

install-basic-tools-from-mas() {
    ## Line
    echo -e "${YELLOW}Install Line${CLEAR}"
    mas install 539883307

    ## Dropover - Easier Drag & Drop
    echo -e "${YELLOW}Install Dropover${CLEAR}"
    mas install 1355679052

    ## RunCat
    echo -e "${YELLOW}Install Run Cat${CLEAR}"
    mas install 1429033973

    ## Usage
    echo -e "${YELLOW}Install Usage${CLEAR}"
    mas install 1561788435

    ## Horo 計時器
    echo -e "${YELLOW}Install Horo${CLEAR}"
    mas install 1437226581

    ## Amphetamine 休眠設定
    echo -e "${YELLOW}Install Amphetamine${CLEAR}"
    mas install 937984704

    ## Unzip - RAR ZIP 7Z Unarchiver
    echo -e "${YELLOW}Install Unzip - RAR ZIP 7Z Unarchiver${CLEAR}"
    mas install 1537056818

}

install-game() {
    ## Steam
    echo -e "${YELLOW}Install Steam${CLEAR}"
    brew install --cask Steam

    ## FF14
    echo -e "${YELLOW}Install XIV on Mac${CLEAR}"
    brew install --cask xiv-on-mac
}

install-office() {
    ## Numbers
    echo -e "${YELLOW}Install Numbers${CLEAR}"
    mas install 409203825

    ## Pages
    echo -e "${YELLOW}Install Pages${CLEAR}"
    mas install 409201541

    ## CleverPDF
    echo -e "${YELLOW}Install CleverPDF${CLEAR}"
    mas install 1445515197
}

install-video-clip() {
    ## Final Cut Pro
    echo -e "${YELLOW}Install Final Cut Pro${CLEAR}"
    mas install 424389933

    ## Motion
    echo -e "${YELLOW}Install Motion${CLEAR}"
    mas install 434290957

    ## Compressor
    echo -e "${YELLOW}Install Compressor${CLEAR}"
    mas install 424390742

    ## Logic Pro
    echo -e "${YELLOW}Install Logic Pro${CLEAR}"
    mas install 634148309

    ## MainStage
    echo -e "${YELLOW}Install MainStage${CLEAR}"
    mas install 634159523
}

install-paint() {
    ## Clip Studio Paint
    echo -e "${YELLOW}Install Clip Studio Paint${CLEAR}"
    brew install --cask clip-studio-paint

    ## Blender
    echo -e "${YELLOW}Install Blender${CLEAR}"
    brew install --cask blender
}

check-by-doctor() {
    echo -e "${GREEN}Checking by Brew Doctor!${CLEAR}"
    brew doctor
}

php-laravel-packages() {

    ## php
    echo -e "${YELLOW}Install php${CLEAR}"
    brew install php

    ## mysql
    echo -e "${YELLOW}Install mysql${CLEAR}"
    brew install mysql

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

    echo -e "${GREEN}Starting install dev-software !${CLEAR}"
    install-dev-software

    echo -e "${GREEN}Starting Install basic-tools-from-brew !${CLEAR}"
    install-basic-tools-from-brew

    echo -e "${GREEN}Starting Install basic-tools-from-mas !${CLEAR}"
    install-basic-tools-from-mas

    echo -e "${GREEN}Starting Install php-laravel-packages !${CLEAR}"
    php-laravel-packages

    echo -e "${GREEN}Starting Install game !${CLEAR}"
    install-game

    echo -e "${GREEN}Starting Install Video Clip !${CLEAR}"
    install-video-clip

    echo -e "${GREEN}Starting Install Panit !${CLEAR}"
    install-paint

    echo -e "${GREEN}Starting Install Office !${CLEAR}"
    install-office

    echo -e "${GREEN}Starting Check !${CLEAR}"
    check-by-doctor
}

install-all
