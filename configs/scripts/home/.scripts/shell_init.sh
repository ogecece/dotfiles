#!/bin/sh

# github-cli completions
eval "$(gh completion -s zsh)"

# virtualenvwrapper lazy init
source /usr/bin/virtualenvwrapper_lazy.sh

# start pyenv
eval "$(pyenv init -)"
