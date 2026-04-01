return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			-- Don't set flavour here - auto-dark-mode.nvim handles switching
			-- by calling colorscheme("catppuccin-mocha") or ("catppuccin-latte")
			transparent_background = false,
			integrations = {
				blink_cmp = true,
				diffview = true,
				gitsigns = true,
				mason = true,
				mini = {
					enabled = true,
					indentscope_color = "lavender",
				},
				neogit = true,
				neotree = true,
				neotest = true,
				snacks = true,
				telescope = { enabled = true },
				treesitter = true,
				which_key = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
		},
	},
}
