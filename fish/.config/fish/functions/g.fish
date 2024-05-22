if type -q git
    function g --wraps git
        command git $argv
    end
end
