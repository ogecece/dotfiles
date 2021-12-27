# defaults
export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="brave"

# locales
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="pt_BR.UTF-8"
export LC_TIME="pt_BR.UTF-8"
export LC_COLLATE="pt_BR.UTF-8"
export LC_MONETARY="pt_BR.UTF-8"
export LC_MESSAGES="pt_BR.UTF-8"
export LC_PAPER="pt_BR.UTF-8"
export LC_NAME="pt_BR.UTF-8"
export LC_ADDRESS="pt_BR.UTF-8"
export LC_TELEPHONE="pt_BR.UTF-8"
export LC_MEASUREMENT="pt_BR.UTF-8"
export LC_IDENTIFICATION="pt_BR.UTF-8"

# coloring less and man
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline


# add user binaries to PATH
export PATH="$HOME/.local/bin:$PATH"

# add user scripts to PATH
export PATH="$HOME/.scripts:$PATH"

# setup pyenv's path
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# modify virtualenvwrapper's and poetry's virtualenv's path
export POETRY_VIRTUALENVS_PATH="$HOME/work/.virtualenvs"
export WORKON_HOME="$HOME/work/.virtualenvs"

# force virtualenvwrapper python to be python3
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"

# virtualenvwrapper doesn't cd after activate
export VIRTUALENVWRAPPER_WORKON_CD=0
