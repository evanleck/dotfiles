# Pull in asdf.
set --local asdf_fish (brew --prefix asdf)/libexec/asdf.fish

if type -q brew and test -f $asdf_fish
	source $asdf_fish
end
