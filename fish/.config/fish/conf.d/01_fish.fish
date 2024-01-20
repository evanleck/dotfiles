# This adds plugins added through devbox to the path.
# Portions of this are borrowed from nix-env.fish
#   https://github.com/lilyball/nix-env.fish/blob/master/conf.d/nix-env.fish
if type -q devbox
	set --local share "$(devbox global path)/.devbox/nix/profile/default/share/fish"

	if test -d $share
		set --local functions "$share/vendor_functions.d"
		set --local completions "$share/vendor_completions.d"
		set --local conf "$share/vendor_conf.d"

		# Load additional functions
		if test -d $functions
			# Insert before $__fish_data_dir
			if set -l idx (contains --index -- $__fish_data_dir/functions $fish_function_path)
				set -l new_function_path $fish_function_path[1..$idx]
				set -e new_function_path[$idx]
				set -a new_function_path $functions

				set fish_function_path $new_function_path $fish_function_path[$idx..-1]
			else
				set -a fish_function_path $functions
			end
		end

		# Load additional completions
		if test -d $completions
			# Insert before $__fish_data_dir
			if set -l idx (contains --index -- $__fish_data_dir/completions $fish_complete_path)
				set -l new_complete_path $fish_complete_path[1..$idx]
				set -e new_complete_path[$idx]
				set -a new_complete_path $completions

				set fish_complete_path $new_complete_path $fish_complete_path[$idx..-1]
			else
				set -a fish_complete_path $completions
			end
		end

		# Load additional configuration
		if test -d $conf
			for file in $conf/*.fish
				source $file
			end
		end
	end
end
