if type -q lazygit
    function gg --wraps lazygit
        command lazygit $argz
    end
end
