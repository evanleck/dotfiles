set --local editors "nvim" "hx" "vim"

for editor in $editors;
	if type -q $editor
		set -x EDITOR $editor
		break
	end
end
