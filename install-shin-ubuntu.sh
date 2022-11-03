#!/usr/bin/env bash
#use this script need type "chmod u+x *.sh" first and then you run this script

export NEEDRESTART_MODE=a
# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
CLEAR='\033[0m'   # Clear color and formatting

# Setup script for setting up a new macos machine
echo -e "${GREEN}Starting Install !${CLEAR}"

install-dev-tools() {

    ## 設定網路
    cd
    # echo -e "${YELLOW}Set Network Manager${CLEAR}"
    # cd etc/netplan
    # sudo nano 00-installer-config.yaml
    # sudo grep -q '^  renderer:' /etc/netplan/00-installer-config.yaml || sudo chmod 777 /etc/netplan/00-installer-config.yaml && echo '  renderer: NetworkManager' >>/etc/netplan/00-installer-config.yaml && sudo chmod 644 /etc/netplan/00-installer-config.yaml
    # sudo netplan apply

    echo -e "${YELLOW}Set apt update${CLEAR}"
    sudo -E apt update

    echo -e "${YELLOW}Set apt upgrade${CLEAR}"
    sudo -E apt -y upgrade

    ## spice-vdagent虛擬機共享剪貼簿 與共享目錄
    # echo -e "${YELLOW}Install Spice-vdagent ${CLEAR}"
    # sudo -E apt install spice-vdagent
    # sudo mkdir sharedir
    # sudo mount -t 9p -o trans=virtio share sharedir -oversion=9p2000.L
    # sudo gpasswd -a yocat dialout
    # sudo chmod g+x ./*.sh

    ## Visual Studio Code
    echo -e "${YELLOW}Install Visual Studio Code${CLEAR}"
    wget -O vscode_arm64.deb https://az764295.vo.msecnd.net/stable/d045a5eda657f4d7b676dedbfa7aab8207f8a075/code_1.72.2-1665612990_arm64.deb
    sudo -E dpkg -i ./vscode_arm64.deb
    sudo rm vscode_arm64.deb

    ## Docker
    echo -e "${YELLOW}Install Docker${CLEAR}"
    wget -O containerd.io_1.6.9-1_arm64.deb https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/containerd.io_1.6.9-1_arm64.deb
    wget -O docker-ce_20.10.21_3-0_ubuntu-jammy_arm64.deb https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/docker-ce-cli_20.10.21~3-0~ubuntu-jammy_arm64.deb
    wget -O docker-ce-cli_20.10.21_3-0_ubuntu-jammy_arm64.deb https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/docker-ce_20.10.21~3-0~ubuntu-jammy_arm64.deb
    wget -O docker-compose-plugin_2.6.0_ubuntu-jammy_arm64.deb https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/arm64/docker-compose-plugin_2.6.0~ubuntu-jammy_arm64.deb
    sudo -E dpkg -i ./containerd.io_1.6.9-1_arm64.deb \
        ./docker-ce_20.10.21_3-0_ubuntu-jammy_arm64.deb \
        ./docker-ce-cli_20.10.21_3-0_ubuntu-jammy_arm64.deb \
        ./docker-compose-plugin_2.6.0_ubuntu-jammy_arm64.deb
    docker --version
    sudo rm ./containerd.io_1.6.9-1_arm64.deb \
        ./docker-ce_20.10.21_3-0_ubuntu-jammy_arm64.deb \
        ./docker-ce-cli_20.10.21_3-0_ubuntu-jammy_arm64.deb \
        ./docker-compose-plugin_2.6.0_ubuntu-jammy_arm64.deb

    ## Vagrant
    echo -e "${YELLOW}Install Vagrant${CLEAR}"
    sudo -E apt -y install vagrant

    ## ngrok
    echo -e "${YELLOW}Install ngrok${CLEAR}"
    sudo snap install ngrok
}

install-dev-software() {
    ## NPM
    echo -e "${YELLOW}Install NPM${CLEAR}"
    sudo -E apt -y install npm

    ## Node
    echo -e "${YELLOW}Install Node${CLEAR}"
    sudo curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt install -y nodejs

    ## Pip3
    echo -e "${YELLOW}Set Pip3${CLEAR}"
    sudo -E apt -y install python3-pip

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
    sudo -E apt -y install firefox

    ## Google Chrome
    echo -e "${YELLOW}Install Google Chrome${CLEAR}"
    sudo -E apt -y install chromium-browser
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
