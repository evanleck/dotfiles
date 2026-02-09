if type -q helix
    function hx --wraps helix
        command helix $argv
    end
end

