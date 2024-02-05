function hx-inject --description "Create a project-local Helix configuration file"
	set --function pwd (pwd)
	set --function ppwd (string replace "$HOME" "~" $pwd)
	set --function templates "$HOME/.config/helix/templates"
	set --function options (command ls $templates)

	# Exit early if no templates around found.
	if not test -d $templates
		set --local tmpls (string replace "$HOME" "~" $templates)
		echo "No Helix language templates found in $tmpls. Exiting."

		return
	end

	if test -d ".helix"
		echo "Project-local Helix configuration directory already exists"
	else
		echo "Creating project-local Helix directory: $ppwd/.helix"
		mkdir "$pwd/.helix"
	end

	if test -f ".helix/languages.toml"
		echo "Project-local Helix configuration file already exists."
		echo
		echo "Once complete, please open the project-local configuration to confirm that
no duplicate entries exist. Configurations from this script will be appended to
the existing file."
		echo
	else
		echo "Creating project-local Helix configuration file: $ppwd/.helix/languages.toml"
		touch "$pwd/.helix/languages.toml"
	end

	echo

	for option in $options;
		read -p "echo \"Append configuration for $(basename $option .toml)? (y/N):\" " -l confirm

		switch $confirm
			case Y y
				command cat "$templates/$option" >> "$pwd/.helix/languages.toml"
			case '' N n
				# Skip it.
		end
	end

	echo
	echo "All done. Check $ppwd/.helix/languages.toml for details."
end
