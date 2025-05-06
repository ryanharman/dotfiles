return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.comment").setup()
		require("mini.pairs").setup()

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

		-- 📂 Breadcrumb-style filename
		local function breadcrumb_filename()
			local filepath = vim.api.nvim_buf_get_name(0)
			if filepath == "" then
				return "[No Name]"
			end

			local rel_path = vim.fn.fnamemodify(filepath, ":.")

			-- Replace path separators with ›
			local sep = package.config:sub(1, 1) -- handles '/' vs '\\'
			local parts = vim.split(rel_path, sep)
			return table.concat(parts, " › ")
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
					local filename = breadcrumb_filename()
					local git = git_branch()
					local fileinfo = statusline.section_fileinfo({})
					local location = "%2l:%-2v"

					return table.concat({
						" " .. filename .. " | " .. git,
						"%=" .. "  " .. fileinfo .. " | " .. location .. " ",
					}, " ")
				end,
				inactive = nil,
			},
		})
	end,
}
