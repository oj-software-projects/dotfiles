-- ~/.config/yazi/init.lua

-- UI / Border setup
require("full-border"):setup()

-- Zoxide integration
require("zoxide"):setup({
	update_db = true,
})

-- ~/.config/yazi/init.lua
-- install: ya pkg add dedukun/bookmarks
require("bookmarks"):setup({
	last_directory = { enable = false, persist = false, mode = "dir" },
	persist = "all",
	desc_format = "full",
	file_pick_mode = "parent",
	custom_desc_input = false,
	show_keys = false,
	notify = {
		enable = false,
		timeout = 1,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})
