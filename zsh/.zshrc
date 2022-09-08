# Conditionally source a script.
source_if_present() {
  if [[ -f "$1" ]]
  then
    source "$1"
  fi
}

# Brew completions for ZSH.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -U colors && colors
autoload -Uz compinit && compinit -i

HISTFILE="${HOME}/.zsh_history"
HISTSIZE='10000'
SAVEHIST='10000'

# Tweak syntax highlighting colors.
#   https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[alias]='fg=default,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=default,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=default,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=default,bold'

source "${HOME}/.aliases"

# History settings
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

setopt noflowcontrol
setopt promptsubst

# ASDF
source_if_present "${HOME}/.asdf/asdf.sh"
source_if_present "/usr/local/opt/asdf/asdf.sh"

# FZF
source_if_present "${HOME}/.fzf.zsh"
source_if_present "/usr/share/fzf/shell/key-bindings.zsh"

# FZF on Debian
source_if_present "/usr/share/doc/fzf/examples/key-bindings.zsh"
source_if_present "/usr/share/doc/fzf/examples/completion.zsh"

# Autojump
source_if_present "/usr/local/etc/profile.d/autojump.sh"
source_if_present "/usr/share/autojump/autojump.zsh"

# ZSH autosuggestions
source_if_present "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source_if_present "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ZSH syntax highlighting
source_if_present "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_present "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
