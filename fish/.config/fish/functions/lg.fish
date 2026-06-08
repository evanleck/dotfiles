if type -q lazygit
    function lg --wraps lazygit
        command lazygit $argv
    end
end
