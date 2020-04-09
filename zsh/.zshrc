# This git prompt is taken from https://github.com/slashbeast/conf-mgmt/blob/master/roles/home_files/files/DOTzshrc
setup_git_prompt() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    unset git_prompt
    return 0
  fi

  local git_status_dirty git_branch

  if [ "$(git --no-optional-locks status --untracked-files='no' --porcelain)" ]; then
    git_status_dirty=" %{$fg[green]%}✗%{$fg[default]%}"
  else
    unset git_status_dirty
  fi

  git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
  git_branch="${git_branch#refs/heads/}"

  if [ "${#git_branch}" -ge 24 ]; then
    git_branch="${git_branch:0:21}..."
  fi

  git_branch="${git_branch:-no branch}"
  git_prompt=" %{$fg[blue]%}git:(%{$fg[red]%}${git_branch}%{$fg[blue]%})${git_status_dirty}"
}

precmd() {
  setup_git_prompt
}

# Brew completions for ZSH.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -U colors && colors
autoload -Uz compinit && compinit

HISTFILE="${HOME}/.zsh_history"
HISTSIZE='10000'
SAVEHIST='10000'
PROMPT='%B%{$fg[cyan]%}%1~${git_prompt} %b%{$fg[default]%}%k'

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

source "${HOME}/.fzf.zsh"
source "/usr/local/etc/profile.d/autojump.sh"
source "/usr/local/opt/asdf/asdf.sh"
source "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
