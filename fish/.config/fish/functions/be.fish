if type -q bundle
	function be --wraps bundle
		command bundle exec $argv
	end
end
