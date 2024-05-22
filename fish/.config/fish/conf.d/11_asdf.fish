# Pull in asdf.
set --local asdf "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish"

if test -f $asdf
    source $asdf
end
