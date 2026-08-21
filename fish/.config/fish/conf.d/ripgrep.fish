set --local ripconf "$HOME/.config/ripgrep/config"

if type -q rg; and test -f $ripconf
    set -x RIPGREP_CONFIG_PATH $ripconf
end
