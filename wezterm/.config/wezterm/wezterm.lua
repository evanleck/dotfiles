local wezterm = require 'wezterm'
local keys = require 'keys'

local fish = wezterm.home_dir .. '/.local/share/devbox/global/default/.devbox/nix/profile/default/bin/fish'

return {
  bold_brightens_ansi_colors = "BrightAndBold",
  color_scheme = "Catppuccin Mocha",
  default_prog = { fish, '-l' },
  font = wezterm.font('JetBrains Mono', { weight = 'DemiBold' }),
  font_size = 13,
  keys = keys,
  native_macos_fullscreen_mode = false,
  set_environment_variables = {
    SHELL = fish
  },
  window_decorations = 'RESIZE',
  window_frame = {
    font = wezterm.font('JetBrains Mono', { weight = 'Bold' }),
    font_size = 13,
  }
}
