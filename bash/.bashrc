# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# User specific environment
if ! [[ "${PATH}" =~ "${HOME}/.local/bin:" ]]
then
    PATH="${HOME}/.local/bin:${PATH}"
fi

export PATH

source "${HOME}/.aliases"
source "${HOME}/.env"

[[ -f "${HOME}/.private.env" ]] && source "${HOME}/.private.env"
[ -f "${HOME}/.fzf.bash" ] && source "${HOME}/.fzf.bash"

# FZF for Linux.
[ -f "/usr/share/fzf/shell/key-bindings.bash" ] && source "/usr/share/fzf/shell/key-bindings.bash"

# ASDF
source "${HOME}/.asdf/asdf.sh"
source "${HOME}/.asdf/completions/asdf.bash"
