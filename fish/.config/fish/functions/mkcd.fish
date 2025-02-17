function mkcd --description "mkdir and cd into that new dir"
    if test (count $argv) -ne 1
        echo "You must specify exactly one directory to create and move into."
    else
        set --function dir $argv[1]
        mkdir -p $dir

        if test $status = 0
            cd $dir
        end
    end
end
