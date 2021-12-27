#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


setup_ssh() {
    if [[ ! -f ~/.ssh/id_rsa || ! -f ~/.ssh/id_rsa.pub ]]; then
        tput setaf 7
        echo "################################################################"
        echo "#### Setup your SSH"
        echo "################################################################"
        tput sgr0

        mkdir -p ~/.ssh

        echo
        echo "Write your id_rsa private key..."

        vi ~/.ssh/id_rsa
        chmod 600 ~/.ssh/id_rsa

        echo
        echo "Now write your id_rsa.pub public key..."

        vi ~/.ssh/id_rsa.pub
    fi

    echo
    tput setaf 2
    echo "################################################################"
    echo "#### SSH is set up"
    echo "################################################################"
    tput sgr0
}


setup_git() {
    if [[ ! $(git config --global --get user.name) || ! $(git config --global --get user.email) ]]; then
        tput setaf 7
        echo "################################################################"
        echo "#### Setup your Git"
        echo "################################################################"
        tput sgr0

        echo
        echo "Type your name..."

        read GIT_NAME

        git config --global user.name $GIT_NAME


        echo
        echo "Type your email..."

        read GIT_EMAIL

        git config --global user.email $GIT_EMAIL
        git config --global core.editor vim
        git config --global init.defaultBranch main
    fi

    echo
    tput setaf 2
    echo "################################################################"
    echo "#### Git is set up"
    echo "################################################################"
    tput sgr0
}


setup_dotfiles_repo() {
    if [[ ! -d ~/.dotfiles ]]; then
        git clone git@github.com:giuliocc/dotfiles ~/.dotfiles
    fi

    chmod +x ~/.dotfiles/*.sh

    echo
    tput setaf 2
    echo "################################################################"
    echo "#### Dotfiles repo is set up"
    echo "################################################################"
    tput sgr0
}

echo
tput setaf 6;
echo "################################################################"
echo "Starting initial setup..."
echo "################################################################"
tput sgr0

echo
tput setaf 4;
echo "################################################################"
echo "Configuring SSH"
echo "################################################################"
tput sgr0

setup_ssh

echo
tput setaf 4;
echo "################################################################"
echo "Configuring Git"
echo "################################################################"
tput sgr0

setup_git

echo
tput setaf 4;
echo "################################################################"
echo "Configuring Dotfiles repo"
echo "################################################################"
tput sgr0

setup_dotfiles_repo

echo
tput setaf 6;
echo "################################################################"
echo "Initial setup is complete"
echo "################################################################"
tput sgr0
