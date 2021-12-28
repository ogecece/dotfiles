#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


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
