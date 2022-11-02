#!/usr/bin/env bash
#use this script need type "chmod u+x *.sh" first and then you run this script

export NEEDRESTART_MODE=a
# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
CLEAR='\033[0m'   # Clear color and formatting

# Setup script for setting up a new macos machine
echo -e "${GREEN}Starting Install !${CLEAR}"

# Setup /etc/sudoers for sudo without password prompt
# echo -e "${GREEN}Setup NOPASSWD for %staff ${CLEAR}"
# sudo grep -q '^yocat' /etc/sudoers || sudo echo 'yocat          ALL = (ALL) NOPASSWD: ALL/' >> /etc/sudoers

install-dev-tools() {
    sudo -E apt update
    # sudo -E apt list --upgradable
    sudo -E apt -y upgrade

    ## 設定網路
    echo -e "${YELLOW}Set Network Manager${CLEAR}"
    # cd etc/netplan
    # sudo nano 00-installer-config.yaml
    sudo grep -q '^renderer:' etc/netplan/00-installer-config.yaml || echo '  renderer: NerworkManager' >>etc/netplan/00-installer-config.yaml
    netplan apply

    ## spice-vdagent spice-webdavd虛擬機共享目錄與剪貼簿
    echo -e "${YELLOW}Install Spice-vdagent Spice-webdavd${CLEAR}"
    sudo -E apt install spice-vdagent spice-webdavd

    ## Visual Studio Code
    echo -e "${YELLOW}Install Visual Studio Code${CLEAR}"
    wget -O vscode_arm64.deb https://az764295.vo.msecnd.net/stable/d045a5eda657f4d7b676dedbfa7aab8207f8a075/code_1.72.2-1665612990_arm64.deb
    # sudo dpkg -i ./vscode_arm64.deb
    sudo -E apt install vscode_arm64.deb

    ## Vagrant
    echo -e "${YELLOW}Install Vagrant${CLEAR}"
    sudo -E apt install vagrant -y

    ## ngrok
    echo -e "${YELLOW}Install ngrok${CLEAR}"
    snap install ngrok -y

}

install-dev-software() {

    ## NPM
    echo -e "${YELLOW}Install NPM${CLEAR}"
    sudo -E apt -y install npm

    ##NVM
    echo -e "${YELLOW}Install NVM${CLEAR}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    source ~/.bashrc

    ## Node
    echo -e "${YELLOW}Install Node${CLEAR}"
    nvm install node
    node --version

    ## nginx
    echo -e "${YELLOW}Install nginx${CLEAR}"
    sudo -E apt -y install nginx
    sudo ufw allow 'Nginx HTTP'

    ## mosquitto
    echo -e "${YELLOW}Install mosquitto${CLEAR}"
    sudo -E apt -y install mosquitto

    ## git
    echo -e "${YELLOW}Set GIT${CLEAR}"
    git config --global user.email "noiecat128@gmail.com"
    git config --global user.name "Shin"

    ## yarn
    echo -e "${YELLOW}Install yarn${CLEAR}"
    npm install -g -y yarn

    ## pnpm
    echo -e "${YELLOW}Install pnpm${CLEAR}"
    npm install -g -y pnpm

}

install-basic-tools() {
    ## Fire Fox
    echo -e "${YELLOW}Install Fire Fox${CLEAR}"

    sudo -E apt install firefox

    ## Google Chrome
    echo -e "${YELLOW}Install Google Chrome${CLEAR}"
    sudo -E apt install chromium-browser
}

php-packages() {
    ## php
    echo -e "${YELLOW}Install php${CLEAR}"
    sudo -E apt -y install php8.1-cli
    sudo -E apt -y install php-cli unzip
    curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
    HASH=$(curl -sS https://composer.github.io/installer.sig)
    php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

    ## composer
    echo -e "${YELLOW}Install composer${CLEAR}"
    sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

    ## mysql
    echo -e "${YELLOW}Install mysql${CLEAR}"
    sudo -E apt -y install mysql-server
}

check-by-dpkg() {
    echo -e "${GREEN}Checking !${CLEAR}"
    dpkg --audit
}

install-all() {
    echo -e "${GREEN}Starting Install dev-tools !${CLEAR}"
    install-dev-tools

    echo -e "${GREEN}Starting install dev-software !${CLEAR}"
    install-dev-software

    echo -e "${GREEN}Starting Install basic-tools !${CLEAR}"
    install-basic-tools

    echo -e "${GREEN}Starting Install php-packages !${CLEAR}"
    php-packages

    echo -e "${GREEN}Starting Check !${CLEAR}"
    check-by-dpkg

}

install-all
