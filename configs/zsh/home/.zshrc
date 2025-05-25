# APPEARANCE

### coloring less and man
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline


# PYTHON

## poetry
export POETRY_VIRTUALENVS_PATH="$HOME/work/.virtualenvs"

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

## virtualenvwrapper
export WORKON_HOME="$HOME/work/.virtualenvs"

### virtualenvwrapper doesn't cd after activate
export VIRTUALENVWRAPPER_WORKON_CD=0

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
source /usr/bin/virtualenvwrapper_lazy.sh


# NODE

## nvm
source /usr/share/nvm/init-nvm.sh


# HISTORY

### unlimited commands
export SAVEHIST=1000000000
export HISTSIZE=1000000000
### save file
export HISTFILE=$HOME/.zsh_history
### don't search duplicates when using ctrl+r|f
setopt HIST_FIND_NO_DUPS
### don't write blanks
setopt HIST_REDUCE_BLANKS
### write to history immediately after command
setopt INC_APPEND_HISTORY
### reverse-i-search
bindkey '^R' history-incremental-search-backward
### history-search-multi-word
source $HOME/.config/zsh/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh
### up-arrow searches
bindkey "^[[A" history-beginning-search-backward
### down-arrow searches
bindkey "^[[B" history-beginning-search-forward


# PROMPT

## pure
### initialize the prompt system
autoload -U promptinit; promptinit
prompt pure


# NAVIGATION

## zsh-z (jump to frecent dirs)
source $HOME/.config/zsh/plugins/zsh-z/zsh-z.plugin.zsh


# AUTOCOMPLETION

### enable autocompletion
autoload -U compinit && compinit
### make it pretty
zstyle ':completion:*' menu select


# AUTOSUGGESTION

## zsh-autosuggestions
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
### disable underline on paths
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none


# SYNTAX HIGHLIGHTING

## zsh-syntax-highlighting
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# GENERAL

### enable vi-mode
bindkey -v
### fix vi-mode character deletion after entering insert mode
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
### case-insensitive globbing
setopt NO_CASE_GLOB
### show hidden files
setopt GLOBDOTS
### correct mistyped commands
setopt CORRECT


# ALIASES

### editor
alias v="vim ."
alias n="lvim ."

### list
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

### Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

### readable output
alias df='df -h'

### pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias rmpacmanlock="sudo rm /var/lib/pacman/db.lck"

### arcolinux logout unlock
alias rmlogoutlock="sudo rm /tmp/arcologout.lock"

### which graphical card is working
alias whichvga="/usr/local/bin/arcolinux-which-vga"

### free
alias free="free -mt"

### continue download
alias wget="wget -c"

### userlist
alias userlist="cut -d: -f1 /etc/passwd"

### merge new settings
alias merge="xrdb -merge ~/.Xresources"

## Aliases for software managment
### pacman or pm
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syyu'

### yay as aur helper - updates everything
alias upall="flatpak update -y && yay -Syu --noconfirm"

### ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

### grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

### add new fonts
alias update-fc='sudo fc-cache -fv'

### copy/paste all content of /etc/skel over to home folder - backup of config created - beware
alias skel='[ -d ~/.config ] || mkdir ~/.config && cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/skel/* ~'
### backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

### copy bashrc-latest over on bashrc - cb= copy bashrc
#alias cb='sudo cp /etc/skel/.bashrc ~/.bashrc && source ~/.bashrc'
### copy /etc/skel/.zshrc over on ~/.zshrc - cb= copy zshrc
alias cz='sudo cp /etc/skel/.zshrc ~/.zshrc && exec zsh'

### switch between bash and zsh
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

### switch between lightdm and sddm
alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"

## kill commands
### quickly kill conkies
alias kc='killall conky'
### quickly kill polybar
alias kp='killall polybar'

### hardware info --short
alias hw="hwinfo --short"

### skip integrity check
alias yayskip='yay -S --mflags --skipinteg'
alias trizenskip='trizen -S --skipinteg'

### check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

### get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
### our experimental - best option for the moment
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias ram='rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist'

### mounting the folder Public for exchange between host and guest on virtualbox
alias vbm="sudo /usr/local/bin/arcolinux-vbox-share"

### youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "

alias ytv-best="youtube-dl -f bestvideo+bestaudio "

### Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

### iso and version used to install ArcoLinux
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

### Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

### search content with ripgrep
alias rg="rg --sort path"

### get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

## vim for important configuration files
### know what you do in these files
alias vlightdm="sudo $EDITOR /etc/lightdm/lightdm.conf"
alias vpacman="sudo $EDITOR /etc/pacman.conf"
alias vgrub="sudo $EDITOR /etc/default/grub"
alias vconfgrub="sudo $EDITOR /boot/grub/grub.cfg"
alias vmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"
alias vmirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist"
alias varcomirrorlist='sudo nano /etc/pacman.d/arcolinux-mirrorlist'
alias vsddm="sudo $EDITOR /etc/sddm.conf"
alias vsddmk="sudo $EDITOR /etc/sddm.conf.d/kde_settings.conf"
alias vfstab="sudo $EDITOR /etc/fstab"
alias vnsswitch="sudo $EDITOR /etc/nsswitch.conf"
alias vsamba="sudo $EDITOR /etc/samba/smb.conf"
alias vgnupgconf="sudo nano /etc/pacman.d/gnupg/gpg.conf"
alias valacritty="$EDITOR ~/.config/alacritty/alacritty.yml"
alias vpolybar="$EDITOR ~/.config/polybar/config"
alias vxmonad="$EDITOR ~/.xmonad/xmonad.hs"
alias vvim="$EDITOR ~/.config/lvim"
alias vb="$EDITOR ~/.bashrc"
alias vz="$EDITOR ~/.zshrc"
alias vdot="$EDITOR ~/.dotfiles"

## gpg
### verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
### receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

### fixes
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
alias fix-key="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-sddm-config="/usr/local/bin/arcolinux-fix-sddm-config"
alias fix-pacman-conf="/usr/local/bin/arcolinux-fix-pacman-conf"
alias fix-pacman-keyserver="/usr/local/bin/arcolinux-fix-pacman-gpg-conf"

### maintenance
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias downgrada="sudo downgrade --ala-url https://ant.seedhost.eu/arcolinux/"

## hblock (stop tracking with hblock)
### use unhblock to stop using hblock
alias unhblock="hblock -S none -D none"

### systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

### shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

### update betterlockscreen images
alias bls="betterlockscreen -u /usr/share/backgrounds/arcolinux/"

### give the list of all installed desktops - xsessions desktops
alias xd="ls /usr/share/xsessions"

### ex = EXtractor for all kinds of archives
### usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### arcolinux applications
alias att="arcolinux-tweak-tool"
alias adt="arcolinux-desktop-trasher"
alias abl="arcolinux-betterlockscreen"
alias agm="arcolinux-get-mirrors"
alias amr="arcolinux-mirrorlist-rank-info"
alias aom="arcolinux-osbeck-as-mirror"
alias ars="arcolinux-reflector-simple"
alias atm="arcolinux-tellme"
alias avs="arcolinux-vbox-share"
alias awa="arcolinux-welcome-app"

### remove
alias rmgitcache="rm -r ~/.cache/git"

### moving your personal files and folders from /personal to ~
alias personal='cp -Rf /personal/* ~'

### make a resized to Full HD copy of every file in folder with imagemagick (preserves aspect ratio)
alias resizefullhd='mkdir -p resized; for file in ./*; do convert "$file" -resize 1920x1080^ -set filename:name "%f" "resized/%[filename:name]"; done'

# REPORTING

### reporting tools
# neofetch | lolcat
