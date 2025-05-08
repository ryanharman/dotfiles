return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>gs", "<CMD>Neogit<CR>", mode = "n", desc = "Neogit Status" },
		{ "<leader>gS", "<CMD>Neogit<CR>", mode = "n", desc = "Neogit Status" },
		{ "<leader>gc", "<CMD>Neogit commit<CR>", mode = "n", desc = "Neogit Commit" },
	},
	config = true,
}
