local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_tab_bar = false

config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold" })
config.font_size = 10.0

config.default_prog = { "C:\\Users\\adrian\\AppData\\Local\\Microsoft\\WindowsApps\\pwsh.exe" }

config.window_background_opacity = 0.85
config.win32_system_backdrop = "Acrylic"

config.inactive_pane_hsb = {
	saturation = 0.3,
	brightness = 0.4,
}

config.keys = {
	{ key = "-", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "q", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "CTRL|ALT", action = wezterm.action.TogglePaneZoomState },
	{ key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "t", mods = "CTRL|ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
}

return config
