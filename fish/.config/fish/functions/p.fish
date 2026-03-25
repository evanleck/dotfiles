if type -q paru
    function p --wraps paru --description "Wraps paru with an 'up' and 'rm' subcommand."
        switch "$argv[1]"
            case up
                command paru --sync --refresh --sysupgrade
            case rm
                command paru --remove --recursive $argv[2..-1]
            case '*'
                command paru $argv
        end
    end
end
