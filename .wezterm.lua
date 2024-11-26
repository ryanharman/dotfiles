local wezterm = require("wezterm")

return {
  font_size = 16,
  font = wezterm.font("CommitMono"),
  scrollback_lines = 10000,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  audible_bell = "Disabled",
  line_height = 1.4,
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",
  -- window_background_opacity = 0.85,
  -- macos_window_background_blur = 20,
  term = "xterm-256color",
  color_scheme = "Tokyo Night",
  max_fps = 160,
  -- send_composed_key_when_left_alt_is_pressed = true,
  -- send_composed_key_when_right_alt_is_pressed = false,
}
