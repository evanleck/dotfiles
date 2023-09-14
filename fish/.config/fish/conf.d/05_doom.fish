set --local doom "$HOME/.emacs.d/bin"

if test -d $doom
	fish_add_path $doom
end
