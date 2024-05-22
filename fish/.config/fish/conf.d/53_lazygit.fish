set --local lazy "$HOME/.config/lazygit/config.yml"

if type -q lazygit; and test -f $lazy
    set -x LG_CONFIG_FILE $lazy
end
