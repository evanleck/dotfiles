# https://specifications.freedesktop.org/basedir-spec/latest/
if ! set -q XDG_CONFIG_HOME
    set -x XDG_CONFIG_HOME "$HOME/.config"
end

if ! set -q XDG_DATA_HOME
    set -x XDG_DATA_HOME "$HOME/.local/share"
end
