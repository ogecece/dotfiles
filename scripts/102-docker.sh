#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


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
tput setaf 4;
echo "################################################################"
echo "Configuring docker"
echo "################################################################"
tput sgr0

start_rootless_docker
