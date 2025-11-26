return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
			ensure_installed = {
				"astro",
				"bash",
				"css",
				"dockerfile",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
