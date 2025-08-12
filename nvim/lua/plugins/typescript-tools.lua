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
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "none",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = false,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = false,
				includeInlayFunctionLikeReturnTypeHints = false,
				includeInlayEnumMemberValueHints = false,
				importModuleSpecifierPreference = "shortest",
				includeCompletionsForModuleExports = false,
				quotePreference = "auto",
				autoImportFileExcludePatterns = {
					"node_modules/*",
					".git/*",
					"dist/*",
					"build/*",
				},
			},
			tsserver_locale = "en",
			complete_function_calls = false,
			include_completions_with_insert_text = false,
			jsx_close_tag = {
				enable = false,
			},
			code_lens = "off",
			disable_member_code_lens = true,
		},
		on_attach = function(client, bufnr)
			client.server_capabilities.semanticTokensProvider = nil

			local function organize_imports()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports.ts" },
						diagnostics = {},
					},
				})
			end

			vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", organize_imports, {})
		end,
	},
}
