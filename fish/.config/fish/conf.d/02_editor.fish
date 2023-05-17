if type -q nvim
	set -x EDITOR nvim
else if type -q helix
	set -x EDITOR helix
else if type -q vim
	set -x EDITOR vim
end
