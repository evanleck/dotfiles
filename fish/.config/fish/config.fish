# Add Doom to our PATH.
if test -d ~/.emacs.d/bin
	fish_add_path ~/.emacs.d/bin
end

if type -q nvim
	set -x EDITOR nvim
end

if type -q lazygit
	set -x LG_CONFIG_FILE ~/.config/lazygit/config.yml
end

if type -q ripgrep
	set -x RIPGREP_CONFIG_PATH ~/.config/ripgrep/config
end
