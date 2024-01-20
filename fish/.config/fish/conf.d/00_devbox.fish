# https://www.jetpack.io/devbox/docs/devbox_global/#fish
if type -q devbox
	devbox global shellenv --init-hook | source
end
