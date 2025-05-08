return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"astro",
					"html",
					"javascript",
					"typescript",
					"tsx",
					"graphql",
					"prisma",
					"svelte",
					"lua",
					"vim",
					"vimdoc",
					"php",
					"dockerfile",
					"go",
					"json",
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}

