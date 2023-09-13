# Load in Homebrew
set --local brews "/opt/homebrew/bin/brew" "/usr/local/bin/brew"

for brew in $brews;
	if test -f $brew; and test -x $brew
		eval ($brew shellenv)
	end
end

# Hush, homebrew
if type -q brew
	set -x HOMEBREW_NO_ENV_HINTS 1
else
	echo "Unable to find Homebrew. Visit https://brew.sh to install."
end
