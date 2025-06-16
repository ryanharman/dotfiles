return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.comment").setup()
		require("mini.pairs").setup()
		-- require("mini.ai").setup()
		require("mini.move").setup()

		local statusline = require("mini.statusline")

		-- 🧠 Git branch (Gitsigns or fallback)
		local function git_branch()
			local branch = vim.b.gitsigns_head
			if branch and branch ~= "" then
				return " " .. branch
			end
			local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
			if not handle then
				return "⎇"
			end
			local result = handle:read("*l")
			handle:close()
			return (result and result ~= "") and " " .. result or "⎇"
		end

		-- ⌚ Clock
		local function clock()
			return os.date("%H:%M")
		end

		-- 📂 Breadcrumb-style filename
		-- local function breadcrumb_filename()
		-- 	local filepath = vim.api.nvim_buf_get_name(0)
		-- 	if filepath == "" then
		-- 		return "[No Name]"
		-- 	end
		--
		-- 	local rel_path = vim.fn.fnamemodify(filepath, ":.")
		--
		-- 	-- Replace path separators with ›
		-- 	local sep = package.config:sub(1, 1) -- handles '/' vs '\\'
		-- 	local parts = vim.split(rel_path, sep)
		-- 	return table.concat(parts, " › ")
		-- end

		local function diagnostics_summary()
			local icons = { error = "", warn = "" }
			local bufnr = vim.api.nvim_get_current_buf()

			local counts = {
				error = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR }),
				warn = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN }),
			}

			local result = {}
			if counts.error > 0 then
				table.insert(result, icons.error .. " " .. counts.error)
			end
			if counts.warn > 0 then
				table.insert(result, icons.warn .. " " .. counts.warn)
			end

			return table.concat(result, " ")
		end

		-- Filename only
		local function filename_only()
			local filepath = vim.api.nvim_buf_get_name(0)
			if filepath == "" then
				return "[No Name]"
			end
			local rel_path = vim.fn.fnamemodify(filepath, ":t")
			return rel_path
		end

		-- 🧼 Remove section backgrounds
		for _, group in ipairs({
			"MiniStatuslineModeNormal",
			"MiniStatuslineDevinfo",
			"MiniStatuslineFileinfo",
			"MiniStatuslineLocation",
		}) do
			vim.api.nvim_set_hl(0, group, { link = "Normal" })
		end

		-- 🚀 Setup statusline
		statusline.setup({
			use_icons = vim.g.have_nerd_font,
			content = {
				active = function()
					local filename = filename_only()
					local git = git_branch()
					local fileinfo = statusline.section_fileinfo({})
					local location = "%2l:%-2v"
					local diagnostics = diagnostics_summary()

					return table.concat({
						clock() .. " | " .. filename .. " | " .. git,
						"%=" .. diagnostics .. " | " .. fileinfo .. " | " .. location .. " ",
					}, " ")
				end,
				inactive = nil,
			},
		})
	end,
}
