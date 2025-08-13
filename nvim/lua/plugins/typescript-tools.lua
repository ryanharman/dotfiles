return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	opts = {
		settings = {
			separate_diagnostic_server = false,
			publish_diagnostic_on = "insert_leave",
			expose_as_code_action = {},
			tsserver_plugins = {},
			tsserver_format_options = {},
			tsserver_locale = "en",
			complete_function_calls = false,
			include_completions_with_insert_text = false,
			jsx_close_tag = {
				enable = false,
			},
			code_lens = "off",
			disable_member_code_lens = true,
		},
	},
}
