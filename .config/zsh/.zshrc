# Lines configured by zsh-newuser-install
export ZDOTDIR=$HOME/.config/zsh
export TERM=alacritty

# Enable colors:
autoload -Uz colors && colors

unsetopt BEEP

HISTFILE=$HOME/.zsh_history
HISTSIZE=6000
SAVEHIST=3000
#setopt share_history
# adds commands as they are typed, not at shell exit
#setopt inc_append_history
# expire duplicates first
#setopt HIST_EXPIRE_DUPS_FIRST 
# # do not store duplications
setopt HIST_IGNORE_DUPS
# #ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# # removes blank lines from history
setopt HIST_REDUCE_BLANKS

#setopt correct
#setopt correct_all

setopt extendedglob nomatch menucomplete
setopt interactive_comments
setopt nocasegloB
setopt auto_cd
stty stop undef
zle_highlight=('paste:none')

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # include hidden files.
compinit

autoload -Uz bashcompinit && bashcompinit
autoload -Uz promptinit && promptinit

# Useful Functions:
source "$ZDOTDIR/zsh_functions"

# Normal files
zsh_add_file "zsh_exports"
zsh_add_file "zsh_vim"
zsh_add_file "zsh_aliases"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"

# Bindings
#bindkey '|' autosuggest-accept
bindkey '^u' backward-delete-word
bindkey -v '^?' backward-delete-char

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

NEWLINE=$'\n'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%B%F{4}%fon %F{4}(%F{1}%m%u%c %F{4} %b)%f'
setopt prompt_subst
PS1='%B%F{4}%m %F{2}  %F{12}%~ %f%b${vcs_info_msg_0_}'
PS1+='${NEWLINE}  '
PS4='%D{%s.%9.}+%N:%i> '
