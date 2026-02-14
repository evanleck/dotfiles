function y --description "Wraps yazi and changes directory on exit"
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"

    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end

    rm -f -- "$tmp"
end
