function upandup --description "Update Homebrew, asdf, fisher, and Devbox"
	# Homebrew
	if type -q brew
		brew update
		brew upgrade
	end

	# asdf
	if type -q asdf
		asdf plugin update --all
	end

	# fisher
	if type -q fisher
		fisher update
		exec fish
	end

	# Devbox
	if type -q devbox
		devbox version update
		devbox global update
	end
end
