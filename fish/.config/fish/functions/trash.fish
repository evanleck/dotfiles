function trash --description "Move files and directories to the trash"
    argparse -n trash h/help -- $argv
    or return 1

    if set -q _flag_help
        printf '%s\n' \
            "Usage: trash FILE..." \
            "" \
            "Move each FILE or directory to the user's trash directory:" \
            "  macOS:   ~/.Trash" \
            "  other:   \$XDG_DATA_HOME/Trash (~/.local/share/Trash)"
        return 0
    end

    if test (count $argv) -eq 0
        echo "trash: missing operand" >&2
        echo "Try 'trash --help' for more information." >&2
        return 1
    end

    # macOS has its own Trash location that Finder displays; everywhere else
    # use the freedesktop.org layout, whose `info` files let tools restore
    # the original location.
    set -l use_info 0
    set -l trash_dir
    set -l trash_files
    set -l trash_info

    if test (uname) = Darwin
        set trash_dir $HOME/.Trash
        set trash_files $trash_dir
    else
        set -l data_home $XDG_DATA_HOME
        test -n "$data_home"; or set data_home $HOME/.local/share

        set trash_dir $data_home/Trash
        set trash_files $trash_dir/files
        set trash_info $trash_dir/info
        set use_info 1
    end

    mkdir -p $trash_files
    or return 1

    if test $use_info = 1
        mkdir -p $trash_info $trash_dir/expunged
        or return 1
    end

    set -l result 0

    for path in $argv
        if not test -e "$path" -o -L "$path"
            echo "trash: cannot trash '$path': no such file or directory" >&2
            set result 1
            continue
        end

        # Absolute path, normalised lexically but with symlinks left intact
        # (so a symlink is trashed, not its target). The `path` builtin is
        # portable, unlike GNU `realpath -s`.
        set -l abspath (path normalize -- $path)
        if not string match -q '/*' -- $abspath
            set abspath (path normalize -- $PWD/$abspath)
        end

        if test "$abspath" = / -o "$abspath" = "$HOME"
            echo "trash: refusing to trash '$path'" >&2
            set result 1
            continue
        end

        set -l trash_prefix "$trash_dir/"
        if test "$abspath" = "$trash_dir"; or test (string sub -l (string length $trash_prefix) -- $abspath) = "$trash_prefix"
            echo "trash: refusing to trash '$path': it is inside the trash directory" >&2
            set result 1
            continue
        end

        # Pick a unique name so an already-trashed file is never overwritten.
        set -l name (path basename -- $abspath)
        set -l target $trash_files/$name
        set -l counter 1
        while test -e "$target"; or test $use_info = 1 -a -e "$trash_info/$name.trashinfo"
            set name "$name.$counter"
            set target $trash_files/$name
            set counter (math $counter + 1)
        end

        if not command mv -- "$abspath" "$target"
            echo "trash: failed to move '$path' to the trash" >&2
            set result 1
            continue
        end

        if test $use_info = 1
            # Record the original location so the file can be restored later.
            if not printf '[Trash Info]\nPath=%s\nDeletionDate=%s\n' \
                    (string escape --style=url -- $abspath) \
                    (date +%Y-%m-%dT%H:%M:%S) >"$trash_info/$name.trashinfo"
                command mv -- "$target" "$abspath"
                echo "trash: failed to record '$path' in the trash" >&2
                set result 1
            end
        end
    end

    return $result
end
