return {
	{
		"sindrets/diffview.nvim",
		lazy = true,
		keys = {
			{ "<C-g>", "<CMD>DiffviewOpen<CR>", mode = { "n", "i", "v" }, desc = "Open diffview" },
			{ "<leader>gv", "<CMD>DiffviewOpen<CR>", mode = { "n" }, desc = "Open diffview" },
			{ "<leader>gd", "<CMD>DiffviewOpen main...HEAD<CR>", desc = "Diff current branch against main" },
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
