return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- Explicitly use master branch (recommended)
		build = ":TSUpdate",
		lazy = false, -- Don't lazy-load treesitter
		config = function()
			require("nvim-treesitter.configs").setup({
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
						local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
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

			-- Enable treesitter-based folding (native Neovim feature)
			-- This runs after treesitter setup to enable folding per-buffer
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-folding", { clear = true }),
				callback = function(args)
					local buf = args.buf

					-- Skip special buffers
					if vim.bo[buf].buftype ~= "" then
						return
					end

					-- Enable treesitter folding for this window
					vim.wo[0].foldmethod = "expr"
					vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end,
			})
		end,
	},
}
