# Pull in asdf.
set --local asdf_fish "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish"

if test -f $asdf_fish
	source $asdf_fish
end
