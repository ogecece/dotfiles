#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


install_python_version() {
    echo
    tput setaf 7
    echo "Installing Python version "$1
    tput sgr0

    if pyenv versions | grep $1 &> /dev/null; then
        tput setaf 2
        echo "################################################################"
        echo "#### The version "$1" is already installed"
        echo "################################################################"
        tput sgr0
	else
        # "CC=clang" to avoid pip segmentation fault when installing on Arch Linux
		CC=clang pyenv install -s $1

		echo
		tput setaf 2
		echo "################################################################"
		echo "#### The version "$1" is now installed"
		echo "################################################################"
		tput sgr0
    fi

}

install_python_versions() {
	versions=(
	2.7.18
	3.6.15
	3.7.12
	3.8.12
	3.9.9
	)

	for version in "${versions[@]}"; do
        install_python_version $version
	done

	echo
    tput setaf 2
    echo "################################################################"
    echo "#### All Python versions are installed"
    echo "################################################################"
    tput sgr0
}


echo
tput setaf 4;
echo "################################################################"
echo "Configuring Python versions"
echo "################################################################"
tput sgr0

install_python_versions
