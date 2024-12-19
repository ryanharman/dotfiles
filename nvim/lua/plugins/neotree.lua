return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal right<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_by_name = {
					".git",
					".DS_Store",
					"target",
				},
			},
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
		},
	},
}
