-- nvim-treesitter `main` branch (requires Neovim 0.12+ and the tree-sitter CLI).
-- The plugin only installs parsers/queries; highlighting and indent are enabled
-- per-buffer below via Neovim's built-in treesitter.
local ensure_installed = {
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
}

-- yaml indent can be slow
local indent_disabled = { yaml = true }

local max_filesize = 100 * 1024 -- 100 KB

local function is_large(buf)
	local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
	return ok and stats and stats.size > max_filesize
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false, -- main branch does not support lazy-loading
		config = function()
			local ts = require("nvim-treesitter")
			ts.install(ensure_installed)

			local available = {}
			for _, lang in ipairs(ts.get_available()) do
				available[lang] = true
			end

			local function attach(buf, lang)
				if not vim.api.nvim_buf_is_valid(buf) then
					return
				end
				-- Disable on large files for performance
				if is_large(buf) or not pcall(vim.treesitter.start, buf, lang) then
					return
				end
				if not indent_disabled[lang] then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_attach", { clear = true }),
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang then
						return
					end
					if vim.treesitter.language.add(lang) then
						attach(args.buf, lang)
					elseif available[lang] then
						-- Auto-install missing parsers, then attach once built
						ts.install(lang):await(function()
							vim.schedule(function()
								attach(args.buf, lang)
							end)
						end)
					end
				end,
			})
		end,
	},
}
