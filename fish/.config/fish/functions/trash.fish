function trash --description "Move files to the macOS trash"
	if test (count $argv) -eq 0
		echo "You must specify at least one file to move to the trash."
	else
		for file in $argv
			osascript -e "tell app \"Finder\" to delete POSIX file \"$PWD/$file\"" > /dev/null
		end
	end
end
