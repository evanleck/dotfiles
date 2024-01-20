if type -q devbox
	function db --wraps devbox
		command devbox $argv
	end
end
