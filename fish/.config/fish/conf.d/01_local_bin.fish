set --local local_bin "$HOME/.local/bin"

if test -d $local_bin
    fish_add_path $local_bin
end
