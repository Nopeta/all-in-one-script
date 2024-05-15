#!/usr/bin/env bash
# To execute run:
#
#    zsh update-all.sh
#
# To source and then use individual update-* functions
# first comment out the command at the bottom of the file
# and run:
#
#    source ./update-all.sh
#
# If you want to use this command often copy it to directory
# that you have in PATH (check with `echo $PATH`) like this:
#
#     USER_SCRIPTS="${HOME}/.local/bin"  # change this
#     cp ./update-all.sh $USER_SCRIPTS/update-all
#     chmod +x $USER_SCRIPTS/update-all
#
#  and now you can call the script any time :)

# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
CLEAR='\033[0m'   # Clear color and formatting

update-brew() {
    if ! which brew &>/dev/null; then return; fi

    echo -e "${GREEN}Updating Brew Formula's${CLEAR}"
    brew update
    brew upgrade
    brew cleanup -s

    echo -e "\n${GREEN}Updating Brew Casks${CLEAR}"
    brew outdated --cask
    brew upgrade --cask
    brew cleanup -s

    echo -e "\n${GREEN}Brew Diagnostics${CLEAR}"
    brew doctor
    brew missing
}

update-npm() {
    if ! which npm &>/dev/null; then return; fi

    echo -e "\n${GREEN}Updating npm Packages${CLEAR}"
    npm update -g
}

update-yarn() {
    if ! which yarn &>/dev/null; then return; fi

    echo -e "${GREEN}Updating Brew Formula's${CLEAR}"
    sudo yarn upgrade --latest

    echo -e "${GREEN}Updating yarn 's${CLEAR}"
    brew upgrade yarn
}

update-pip2() {
    if ! which pip2 &>/dev/null; then return; fi
    if ! which python2 &>/dev/null; then return; fi

    echo -e "\n${GREEN}Updating Python 2.7.X pips${CLEAR}"
    python2 -c "import pkg_resources; from subprocess import call; packages = [dist.project_name for dist in pkg_resources.working_set]; call('pip install --upgrade ' + ' '.join(packages), shell=True)"
    #pip2 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip2 install -U
}

update-pip3() {
    if ! which pip3 &>/dev/null; then return; fi
    if ! which python3 &>/dev/null; then return; fi

    echo -e "\n${GREEN}Updating Python 3.X pips${CLEAR}"
    /usr/local/opt/python@3.9/bin/python3.9 -m pip install --upgrade pip
    # python3 -c "import pkg_resources; from subprocess import call; packages = [dist.project_name for dist in pkg_resources.working_set]; call('pip install --upgrade ' + ' '.join(packages), shell=True)"
    #pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
}

update-app_store() {
    if ! which mas &>/dev/null; then return; fi

    echo -e "\n${GREEN}Updating App Store Applications${CLEAR}"
    mas outdated
    mas upgrade
}

update-macos() {
    echo -e "\n${GREEN}Updating Mac OS${CLEAR}"
    softwareupdate -i -a
}

update-all() {
    update-brew
    update-npm
    update-yarn
    update-pip2
    update-pip3
    update-app_store
    update-macos
}

# COMMENT OUT IF SOURCING
update-all
