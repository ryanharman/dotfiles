return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		settings = {
			separate_diagnostic_server = true,
			-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
			-- "remove_unused_imports"|"organize_imports") -- or string "all"
			-- to include all supported code actions
			-- specify commands exposed as code_actions
			expose_as_code_action = {},
			-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
			-- (see 💅 `styled-components` support section)
			tsserver_plugins = {},
			tsserver_format_options = {},
			tsserver_file_preferences = {},
			tsserver_locale = "en",
			include_completions_with_insert_text = true,
			-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
			-- that maybe have a conflict if enable this feature. )
			jsx_close_tag = {
				enable = false,
			},
		},
	},
}
