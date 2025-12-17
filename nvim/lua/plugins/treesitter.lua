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
				highlight = {
					enable = true,
					-- Disable on large files for performance
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = {
					enable = true,
					disable = { "yaml" }, -- yaml indent can be slow
				},
			})
		end,
	},
}
