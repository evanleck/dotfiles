function upandup --description "Update Homebrew, asdf, and Doom"
	# Homebrew
	if type -q brew
		brew update
		brew upgrade
	end

	# asdf
	if type -q asdf
		asdf plugin update --all
	end

	# Doom
	if type -q doom
		doom upgrade
	end
end
