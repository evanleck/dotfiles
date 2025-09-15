local wezterm = require 'wezterm'
local keys = require 'keys'

local scheme = "Catppuccin Mocha"
local colors = wezterm.get_builtin_color_schemes()[scheme]

return {
  adjust_window_size_when_changing_font_size = false,
  bold_brightens_ansi_colors = "BrightAndBold",
  color_scheme = scheme,
  -- font = wezterm.font('JetBrains Mono', { weight = 'DemiBold' }),
  font = wezterm.font('JetBrains Mono'),
  font_size = 12,
  keys = keys,
  native_macos_fullscreen_mode = false,
  show_new_tab_button_in_tab_bar = false,
  show_close_tab_button_in_tabs = false,
  window_decorations = 'RESIZE',
  window_frame = {
    -- font = wezterm.font('JetBrains Mono', { weight = 'Bold' }),
    font = wezterm.font('JetBrains Mono'),
    font_size = 12,

    -- Title bar color tweaks
    active_titlebar_bg = colors.tab_bar.active_tab.fg_color,
    inactive_titlebar_bg = colors.tab_bar.active_tab.fg_color,
  },

  -- Tab bar color tweaks
  colors = {
  	tab_bar = {
  		inactive_tab_edge = colors.tab_bar.active_tab.fg_color,
  		active_tab = {
  			bg_color = colors.background,
  			fg_color = colors.foreground,
  		},
  		inactive_tab = {
  			bg_color = colors.tab_bar.active_tab.fg_color,
  			fg_color = colors.tab_bar.inactive_tab.fg_color,
  		}
  	}
  }
}

