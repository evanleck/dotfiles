# Load ASDF
#   Note that is equivalent to, but faster than, running (brew --prefix asdf).
source /usr/local/opt/asdf/asdf.fish

# Load Autojump
source /usr/local/share/autojump/autojump.fish

# FZF configuration.
set -x FZF_DEFAULT_COMMAND 'rg --files'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_ALT_C_COMMAND "$FZF_DEFAULT_COMMAND"

# Tell ripgrep where to look for configuration.
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/config"

# Tell Homebrew to cleanup.
set -x HOMEBREW_INSTALL_CLEANUP
set -x HOMEBREW_NO_GITHUB_API

set -x EDITOR 'mvim'
set -x VIMHOME "$HOME/.vim"

# Aliases.
alias be 'bundle exec'
alias brewup 'brew update; brew upgrade; brew cask upgrade'
alias c clear
alias cat bat # OMG where has this been all my life?!
alias ls exa # Double OMG, just like above.
alias g git

# Quiet down the greeting.
set fish_greeting ''

# name: Robbyrussell
# author: Bruno Ferreira Pinto, Pawel Zubrycki
function fish_prompt
  if not set -q -g __fish_robbyrussell_functions_defined
    set -g __fish_robbyrussell_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end

    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end

    function _is_git_repo
      git status -s >/dev/null ^/dev/null
    end

    function _repo_branch_name
      eval "_$argv[1]_branch_name"
    end

    function _is_repo_dirty
      eval "_is_$argv[1]_dirty"
    end

    function _repo_type
      if _is_git_repo
        echo 'git'
      end
    end
  end

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  set -l arrow "$red➜ "
  if [ $USER = 'root' ]
    set arrow "$red# "
  end

  set -l cwd $cyan(basename (prompt_pwd))

  set -l repo_type (_repo_type)
  if [ $repo_type ]
    set -l repo_branch $red(_repo_branch_name $repo_type)
    set repo_info "$blue $repo_type:($repo_branch$blue)"

    if [ (_is_repo_dirty $repo_type) ]
      set -l dirty "$yellow ✗"
      set repo_info "$repo_info$dirty"
    end
  end

  echo -n -s $arrow ' '$cwd $repo_info $normal ' '
end
