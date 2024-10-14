if type -q lazygit
    function lg --wraps lazygit
        command lazygit $argz
    end
end
