return {
	{
		"sindrets/diffview.nvim",
		lazy = true,
		keys = {
			{ "<C-g>", "<CMD>DiffviewOpen<CR>", mode = { "n", "i", "v" } },
			{ "<leader>gv", "<CMD>DiffviewOpen<CR>", mode = { "n" } },
		},
		config = {
			file_panel = {
				win_config = {
					position = "right",
				},
			},
			keymaps = {
				view = {
					["<C-g>"] = "<CMD>DiffviewClose<CR>",
				},
				file_panel = {
					["<C-g>"] = "<CMD>DiffviewClose<CR>",
				},
			},
		},
	},
}
