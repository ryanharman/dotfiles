return {
	{
		"github/copilot.vim",
		event = { "InsertEnter" },
		cmd = { "Copilot" },
		config = function()
			-- Optional: Configuration options go here instead of an 'opts' table.

			-- If you use a completion engine like nvim-cmp or blink.cmp, Copilot's
			-- default <Tab> key will conflict. Uncomment these lines to change it to <C-J>:

			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
		end,
	},
}
