#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


stow_dotfiles() {
    targets=(
    home
    root
    )

    for target in "${targets[@]}"; do
        find ./configs -maxdepth 2 -mindepth 2 -type d -name $target | while read dir; do
            program="$(echo $dir | cut -d "/" -f 3)"

            echo
            tput setaf 7
            echo "################################################################"
            echo "####  Stowing "$program" at "$target
            echo "################################################################"
            tput sgr0

            case $target in
                "home" )
                    stow -R -d configs/$program -t ~ home
                    ;;
                "root" )
                    sudo stow -R -d configs/$program -t / root
                    ;;
            esac
            
            echo
            tput setaf 2
            echo "################################################################"
            echo "#### "$program" is stowed"
            echo "################################################################"
            tput sgr0
        done
    done
}


start_rootless_docker() {
    sudo usermod -aG docker $USER
    sudo systemctl enable docker

    echo
    tput setaf 2
    echo "################################################################"
    echo "#### Docker is configured"
    echo "################################################################"
    tput sgr0
}


echo
tput setaf 6;
echo "################################################################"
echo "Starting configuring..."
echo "################################################################"
tput sgr0

echo
tput setaf 4;
echo "################################################################"
echo "Configuring Dotfiles"
echo "################################################################"
tput sgr0

stow_dotfiles

echo
tput setaf 7;
echo "################################################################"
echo "#### Updating Dotfiles submodules"
echo "################################################################"
tput sgr0

git submodule update --init

echo
tput setaf 4;
echo "################################################################"
echo "Configuring default shell"
echo "################################################################"
tput sgr0

chsh -s $(which zsh)

echo
tput setaf 2
echo "################################################################"
echo "#### Default shell is configured"
echo "################################################################"
tput sgr0

echo
tput setaf 4;
echo "################################################################"
echo "Configuring docker"
echo "################################################################"
tput sgr0

start_rootless_docker

echo
tput setaf 4;
echo "################################################################"
echo "Configuring github-cli"
echo "################################################################"
tput sgr0

gh auth login

echo
tput setaf 2
echo "################################################################"
echo "#### github-cli is configured"
echo "################################################################"
tput sgr0

echo
tput setaf 6;
echo "################################################################"
echo "Programs are configured"
echo "################################################################"
tput sgr0

echo
tput setaf 5;
echo "################################################################"
echo "Reboot the system"
echo "################################################################"
tput sgr0
