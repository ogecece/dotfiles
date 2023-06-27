#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


start_rootless_docker() {
    sudo usermod -aG docker $USER
    sudo systemctl enable --now docker

    echo
    tput setaf 2
    echo "################################################################"
    echo "#### Docker is configured"
    echo "################################################################"
    tput sgr0
}

start_podman_compose() {
    sudo systemctl enable --now podman.socket
    pipx install podman-compose
    sudo printf "[registries.search]\nregistries = ['docker.io', 'ghcr.io']" | sudo tee -a /etc/containers/registries.conf

    echo
    tput setaf 2
    echo "################################################################"
    echo "#### Podman is configured"
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

echo
tput setaf 4;
echo "################################################################"
echo "Configuring podman"
echo "################################################################"
tput sgr0

start_podman_compose
