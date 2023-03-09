# Pull in asdf.
if type -q brew and test -f (brew --prefix asdf)/libexec/asdf.fish
	source (brew --prefix asdf)/libexec/asdf.fish
end
