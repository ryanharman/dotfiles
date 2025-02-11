return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		-- I already have these deps in my config so unsure if they're required here
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
