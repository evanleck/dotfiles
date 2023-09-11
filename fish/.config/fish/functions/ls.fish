if type -q eza
	function ls --wraps eza
		command eza --header --long --git --all $argv
	end
end
