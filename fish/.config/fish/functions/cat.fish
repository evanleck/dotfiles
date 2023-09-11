if type -q bat
	function cat --wraps bat
		command bat $argv
	end
end
