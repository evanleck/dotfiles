set --local mise "$HOME/.local/bin/mise"

if test -f $mise
	$mise activate fish | source
end
