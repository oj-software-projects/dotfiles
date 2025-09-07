-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- ---------- Quick Select ----------
config.quick_select_patterns = {
	"=([A-Za-z0-9_]+)",
	"https?://[%w%._~:/%?#%[%]@!$&'()*+,;=-]+",
	"[%w%._%-%/]+%.%w+", -- simple filenames/paths
	"%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x", -- UUID
}

-- ---------- Top-level keybindings ----------
config.keys = {
	{
		key = "t",
		mods = "CTRL",
		action = act.ActivateKeyTable({
			name = "tab_management",
			one_shot = false,
		}),
	},
	{
		key = "p",
		mods = "CTRL",
		action = act.ActivateKeyTable({
			name = "pane_management",
			one_shot = false,
			-- optional: give yourself a bit more time to release Ctrl
			-- timeout_milliseconds = 5500,
		}),
	},
	-- manual reload (define ONCE here, not inside events)
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = act.ReloadConfiguration,
	},
}

-- ---------- Key tables ----------
config.key_tables = {
	tab_management = {
		{ key = "Escape", action = act.PopKeyTable },
		{
			key = "r",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{ key = "j", action = wezterm.action.ShowTabNavigator },
		-- optional tab navigation in table
		{ key = "h", action = act.ActivateTabRelative(-1) },
		{ key = "l", action = act.ActivateTabRelative(1) },
		{ key = "c", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "X", action = act.CloseCurrentTab({ confirm = true }) },
	},

	pane_management = {
		{ key = "Escape", action = act.PopKeyTable },
		{ key = "n", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "N", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		-- pane focus (vim-like)
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },

		-- pane resize (Shift + H/J/K/L)
		{ key = "H", action = act.AdjustPaneSize({ "Left", 3 }) },
		{ key = "J", action = act.AdjustPaneSize({ "Down", 22 }) },
		{ key = "L", action = act.AdjustPaneSize({ "Right", 3 }) },
	},
}

-- ---------- Look & feel ----------
config.color_scheme = "catppuccin-mocha"
config.automatically_reload_config = true
-- config.window_decorations = "NONE"
-- config.default_prog = {"/opt/homebrew/bin/zellij", "-l", "welcome"}

config.font = wezterm.font({
	family = "SauceCodePro Nerd Font",
	weight = "DemiBold",
})
config.font_size = 14.0
config.freetype_load_target = "Light"

config.window_frame = {
	font = wezterm.font({ family = "SauceCodePro Nerd Font", weight = "DemiBold" }),
	font_size = 13,
}

config.show_new_tab_button_in_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_max_width = 22

-- optional macOS niceties
config.native_macos_fullscreen_mode = true
config.window_padding = { left = 4, right = 4, top = 2, bottom = 0 }
config.cursor_blink_rate = 0

-- ---------- Colors & gradients ----------
local color_scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
local bg = wezterm.color.parse(color_scheme.background)
local fg = color_scheme.foreground

local gradient_to = bg
local gradient_from = gradient_to:lighten(0.2)
local gradient = wezterm.color.gradient({
	orientation = "Horizontal",
	colors = { gradient_from, gradient_to },
}, 4)

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config.background = {
	{
		source = { Color = bg },
		opacity = 0.75,
		width = "100%",
		height = "100%",
	},
}
config.macos_window_background_blur = 30

config.colors = {
	tab_bar = {
		background = gradient[4],
		active_tab = {
			bg_color = gradient[1],
			fg_color = fg,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = gradient[2],
			fg_color = fg,
			intensity = "Half",
		},
	},
}
-- config.tab_bar_at_bottom = false

-- ---------- Right status ----------
local function segments_for_right_status(window, pane)
	local bat = ""
	local bis = wezterm.battery_info()
	if bis and #bis > 0 then
		local pct = math.floor((bis[1].state_of_charge or 0) * 100 + 0.5)
		bat = wezterm.nerdfonts.md_battery_high .. (" " .. pct .. "%%")
	end

	local cwd_uri = pane:get_current_working_dir()
	local cwd = cwd_uri and cwd_uri.file_path or ""

	local kt = window:active_key_table()
	if kt then
		return { "[" .. kt .. "]", cwd, bat, wezterm.hostname() }
	else
		return { cwd, bat, wezterm.hostname() }
	end
end

wezterm.on("update-right-status", function(window, pane)
	local segments = segments_for_right_status(window, pane)
	local elements = {}
	for i, seg in ipairs(segments) do
		table.insert(elements, { Foreground = { Color = gradient[i] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = gradient[i] } })
		table.insert(elements, { Text = " " .. seg .. " " })
	end
	window:set_right_status(wezterm.format(elements))
end)

-- ---------- Tab title ----------
local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local tab_bar_color = gradient[4]
	local active_tab_color = gradient[1]
	local hover_tab_color = gradient[2]
	local inactive_tab_color = gradient[3]

	local background
	if tab.is_active then
		background = active_tab_color
	elseif hover then
		background = hover_tab_color
	else
		background = inactive_tab_color
	end

	local title = tab_title(tab)
	title = wezterm.truncate_right(title, max_width - 4)

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = tab_bar_color } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = tab_bar_color } },
		{ Foreground = { Color = background } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- and finally, return the configuration to wezterm
return config
