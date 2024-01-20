set --local ripconf "$HOME/.config/ripgrep/config"

if type -q ripgrep; and test -f $ripconf
	set -x RIPGREP_CONFIG_PATH $ripconf
end
