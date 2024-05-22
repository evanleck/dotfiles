# This tests for at least one of devbox or brew and yells at you if you don't
# have one.
set --local managers devbox brew
set --local found

for manager in $managers
    if type -q $manager
        set --append found $manager
    end
end

if not set -q found
    echo
    echo
    echo "No package manager found. Install either Devbox or Homebrew."
    echo "  https://www.jetpack.io/devbox/docs/installing_devbox/"
    echo "  https://brew.sh"
    echo
end
