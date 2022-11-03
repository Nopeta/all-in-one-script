#!/usr/bin/env bash

# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
CLEAR='\033[0m'   # Clear color and formatting

# Setup script for setting up a new macos machine
echo -e "${GREEN}Starting Install !${CLEAR}"

# Setup /etc/sudoers for sudo without password prompt

install-dev-tools() {

    ## Homebrew
    echo -e "${YELLOW}Install Homebrew${CLEAR}"
    CI=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update

    ## git
    echo -e "${YELLOW}Install GIT${CLEAR}"
    brew install git
    git config --global user.email "tilda.lu@trunk-studio.com"
    git config --global user.name "Tilda"

    ## mas-cli
    ## A simple command line interface for the Mac App Store. Designed for scripting and automation.
    echo -e "${YELLOW}Install mas-cli${CLEAR}"
    brew install mas

}

install-basic-tools() {

    ## Google Chrome
    echo -e "${YELLOW}Install Google Chrome${CLEAR}"
    brew install google-chrome

    ## Google Drive
    echo -e "${YELLOW}Install Google Drive${CLEAR}"
    brew install google-drive

    ## 1Password
    echo -e "${YELLOW}Install 1Password${CLEAR}"
    brew install 1password 1password-cli

    ## Zoom, Slack
    echo -e "${YELLOW}Install Zoom Slack${CLEAR}"
    brew install zoom slack

    ## AnyDesk
    echo -e "${YELLOW}Install AnyDesk${CLEAR}"
    brew install anydesk
}

install-others() {

    ## Unzip - RAR ZIP 7Z Unarchiver
    echo -e "${YELLOW}Install Unzip - RAR ZIP 7Z Unarchiver${CLEAR}"
    mas install 1537056818

}

install-all() {
    echo -e "${GREEN}Starting Install dev-tools !${CLEAR}"
    install-dev-tools

    echo -e "${GREEN}Starting Install basic-tools !${CLEAR}"
    install-basic-tools

    echo -e "${GREEN}Starting Install others !${CLEAR}"
    install-others
}

install-all
