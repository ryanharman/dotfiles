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
		window = {
			mappings = {
				["H"] = function(state)
					local width = vim.api.nvim_win_get_width(state.winid)
					vim.api.nvim_win_set_width(state.winid, math.max(width - 5, 1))
				end,
				["L"] = function(state)
					local width = vim.api.nvim_win_get_width(state.winid)
					vim.api.nvim_win_set_width(state.winid, width + 5)
				end,
			},
		},
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
