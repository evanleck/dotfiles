if [ -f "${HOME}/.bashrc" ]; then
  source "${HOME}/.bashrc"
fi

# Load in Homebrew
[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f "/usr/local/bin/brew" ] && eval "$(/usr/local/bin/brew shellenv)"

# ASDF via Homebrew
[ -f "${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh" ] && source "${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh"

# Tell ripgrep where to look for configuration.
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"

# Tell Homebrew to cleanup.
export HOMEBREW_INSTALL_CLEANUP=1
export HOMEBREW_NO_GITHUB_API=1

# For command line editing.
export EDITOR='nvim'
