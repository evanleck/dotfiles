if type -q eza
    function ls --wraps eza
        command eza --header --long --git --all $argv
    end
else if type -q lsd
    function ls --wraps lsd
        command lsd --long $argv
    end
end
