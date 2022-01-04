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
        chmod +x ~/.dotfiles/*.sh
    fi

    if [[ ! -f ~/.dotfiles/.env ]]; then
        echo
        echo "Write your personal .env..."

        vi ~/.dotfiles/.env
    fi

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

cd ~/.dotfiles
chmod +x scripts/*.sh

echo
tput setaf 6;
echo "################################################################"
echo "Starting installing packages..."
echo "################################################################"
tput sgr0

sh scripts/000-install_packages.sh

echo
tput setaf 6;
echo "################################################################"
echo "Packages are installed"
echo "################################################################"
tput sgr0

echo
tput setaf 6;
echo "################################################################"
echo "Starting configuring base programs..."
echo "################################################################"
tput sgr0

sh scripts/100-configure.sh

echo
tput setaf 6;
echo "################################################################"
echo "Base programs are configured"
echo "################################################################"
tput sgr0

echo
tput setaf 6;
echo "################################################################"
echo "Starting configuring Python..."
echo "################################################################"
tput sgr0

sh scripts/101-python.sh

echo
tput setaf 6;
echo "################################################################"
echo "Python is configured"
echo "################################################################"
tput sgr0

echo
tput setaf 6;
echo "################################################################"
echo "Starting configuring Docker..."
echo "################################################################"
tput sgr0

sh scripts/102-docker.sh

echo
tput setaf 6;
echo "################################################################"
echo "Docker is configured"
echo "################################################################"
tput sgr0

echo
tput setaf 6;
echo "################################################################"
echo "Starting configuring Github..."
echo "################################################################"
tput sgr0

sh scripts/103-github.sh

echo
tput setaf 6;
echo "################################################################"
echo "Github is configured"
echo "################################################################"
tput sgr0

echo
tput setaf 5;
echo "################################################################"
echo "Reboot the system"
echo "################################################################"
tput sgr0
