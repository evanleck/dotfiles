function ls --wraps exa
	command exa --header --long --git --all $argv
end
