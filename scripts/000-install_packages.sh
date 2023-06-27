#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


pacman_package_list=(
autorandr
base-devel
clang
deluge
deluge-gtk
discord_arch_electron
docker
docker-compose
element-desktop
fd
fzf
github-cli
gsimplecal
lxappearance
neovim
newsboat
netavark
noto-fonts-emoji
npm
ntfs-3g
pacutils
picom
pnmixer
podman
pyenv
python-pynvim
python-pip
python-virtualenvwrapper
ripgrep
rust
slop
stow
sxhkd
tldr
tree
ttf-font-awesome
ttf-sourcecodepro-nerd
xorg-xmessage
zathura
zathura-cb
zathura-djvu
zathura-pdf-mupdf
)

yay_package_list=(
bfg
nvm
screenkey-git
tdrop-git
zscroll-git
zsh-pure-prompt
)


update_packages() {
	sudo pacman -Syyu --noconfirm
	yay -Syu --noconfirm

	echo
    tput setaf 2
    echo "################################################################"
    echo "#### Existing packages are updated"
    echo "################################################################"
    tput sgr0
}

install_package() {
	if $2 -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "################################################################"
  		echo "#### The package "$1" is already installed"
      	echo "################################################################"
		tput sgr0
	else
    	tput setaf 7
    	echo "################################################################"
    	echo "####  Installing package "$1
    	echo "################################################################"
    	tput sgr0

		case $2 in
			"pacman" )
				sudo $2 -S --noconfirm --needed $1
				;;
			"yay" )
				yay -S --noconfirm --needed $1
				;;
		esac

		echo
		tput setaf 2
		echo "################################################################"
		echo "#### The package "$1" is now installed"
		echo "################################################################"
		tput sgr0
    fi

}


install_all_packages() {
	helpers=(
	pacman
	yay
	)

	count=0
	for helper in "${helpers[@]}"; do
		declare -n package_list="${helper}_package_list"
		for package_name in "${package_list[@]}"; do
			count=$[count+1]
			tput setaf 7;echo;echo "Installing package nr.  "$count " " $package_name;tput sgr0;
			install_package $package_name $helper
		done
	done

	echo
    tput setaf 2
    echo "################################################################"
    echo "#### All new packages are installed"
    echo "################################################################"
    tput sgr0
}


echo
tput setaf 4;
echo "################################################################"
echo "Updating existing packages"
echo "################################################################"
tput sgr0

update_packages

echo
tput setaf 4;
echo "################################################################"
echo "Installing new packages"
echo "################################################################"
tput sgr0

install_all_packages
