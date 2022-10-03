#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/.emacs.d/bin:$PATH"
# 2 exports
PATH="$HOME/.nodenv/bin:$PATH"
PATH="$HOME/.rbenv/bin:$PATH"

export SHELL=/bin/bash
export TERM=alacritty
export EDITOR=/usr/bin/vim

export MAGENTA="\033[1;31m"
export GREEN="\033[1;32m"
export ORANGE="\033[1;33m"
export BLUE="\033[1;34m"
export PURPLE="\033[1;35m"
export RESET="\033[m"
export BOLD=""

# Git branch details
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="» "

PS1="\[${BLUE}\]\u \[$RESET\]in \[$BLUE\]\w\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$RESET\]\n$symbol\[$RESET\]"
PS2="\[$ORANGE\]→ \[$RESET\]"

# Only show the current directory's name in the tab
PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# Aliases
alias ls="ls --classify --tabsize=0 --group-directories-first --color=auto --human-readable --literal --show-control-chars"
alias l="ls -lF --color=auto" # all files, in long format
alias la="ls -lA" # all files inc dotfiles, in long format
alias lsd='ls -lF --color=auto | grep "^d"' # only directories
alias xmerg='xrdb -merge ~/.Xresources'

alias pacu="sudo pacman -Syu"
alias pacr="sudo pacman -Rs"
alias pac="sudo pacman -S"
alias pacclean="sudo pacman -Sc"
alias pacinf="pacman -Si"
alias pacs="pacman -Ss"

alias aur="yay -S"
alias auru="yay -Syu"

alias fullclean="git checkout master && make clean && rm -f config.h && git reset --hard origin/master"
alias mclean="make clean && rm -f config.h"
alias gac="git add . && git commit -m"
alias patchd="patch --merge -i"

# Py
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/dev/pyproj
source /usr/bin/virtualenvwrapper_lazy.sh

eval "$(nodenv init -)"
eval "$(rbenv init - bash)"
PATH=$HOME/.yarn/bin:$PATH
