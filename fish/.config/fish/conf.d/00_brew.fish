# Load in Homebrew
if test -f /opt/homebrew/bin/brew
	eval (/opt/homebrew/bin/brew shellenv)
else if test -f /usr/local/bin/brew
	eval (/usr/local/bin/brew shellenv)
end

# Hush, homebrew
if type -q brew
	set -x HOMEBREW_NO_ENV_HINTS 1
else
	echo "Unable to find Homebrew. Visit https://brew.sh to install."
end
