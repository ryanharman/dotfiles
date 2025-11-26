return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			ignore_filetypes = { cpp = true },
			log_level = "info",
			disable_inline_completion = false,
			disable_keymaps = false,
			condition = function()
				return false
			end,
		})
	end,
}
