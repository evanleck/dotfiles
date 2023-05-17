if type -q nvim
	set -x EDITOR nvim
else if type -q hx
	set -x EDITOR hx
else if type -q vim
	set -x EDITOR vim
end
