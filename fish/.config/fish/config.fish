# Pull in asdf.
source /usr/local/opt/asdf/libexec/asdf.fish

# Add Homebrew's sbin directory.
fish_add_path /usr/local/sbin

# Add Doom to our PATH.
fish_add_path ~/.emacs.d/bin

# Add our own bin directory to the PATH.
fish_add_path ~/.bin

# Environment variables.
set -x RIPGREP_CONFIG_PATH ~/.config/ripgrep/config
set -x EDITOR nvim

# Aliases.
alias be "bundle exec"
alias c clear
alias cat bat
alias g git
alias ls exa
alias lsa "exa --header --long --git --all"
alias gg lazygit

# Modify Dracula's colors slightly.
#   See conf.d/dracula.fish for the color definitions.
#   See https://github.com/fish-shell/fish-shell/blob/master/doc_src/interactive.rst#syntax-highlighting-variables for variable names.
set -g fish_color_command fish_color_normal --bold
set -g fish_color_error ff5555 --bold # red
set -g fish_color_param fish_color_normal

# Modify hydro's colors.
#   https://github.com/jorgebucaran/hydro#colors
set -g hydro_color_pwd bd93f9  # purple
set -g hydro_color_git 6272a4  # comment
set -g hydro_color_prompt f1fa8c  # yellow
set -g hydro_symbol_git_dirty ' •'

# Quiet down the greeting.
set fish_greeting ''
