# Get the aliases and functions
if [ -f "${HOME}/.bashrc" ]; then
  source "${HOME}/.bashrc"
fi

# ASDF via Git
[ -f "${HOME}/.asdf/asdf.sh" ] && source "${HOME}/.asdf/asdf.sh"
[ -f "${HOME}/.asdf/completions/asdf.bash" ] && source "${HOME}/.asdf/completions/asdf.bash"

# ASDF via Homebrew
[ -f "/usr/local/opt/asdf/libexec/asdf.sh" ] && source "/usr/local/opt/asdf/libexec/asdf.sh"
