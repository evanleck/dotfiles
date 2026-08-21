# Arch registers Helix as `helix` instead of `hx` so I check for both.
set --local editors helix hx nvim vim

for editor in $editors
    if type -q $editor
        set -x EDITOR $editor
        break
    end
end
