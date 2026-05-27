return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", config = true },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- LSP Keymaps - attached when an LSP connects to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", function() Snacks.picker.lsp_definitions() end, "[G]oto [D]efinition")
					map("gr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")
					map("gI", function() Snacks.picker.lsp_implementations() end, "[G]oto [I]mplementation")
					map("<leader>D", function() Snacks.picker.lsp_type_definitions() end, "Type [D]efinition")
					map("<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				end,
			})

			-- Get blink.cmp capabilities for LSP completion support
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure LSP servers using the new vim.lsp.config() API (Neovim 0.11+)
			vim.lsp.config("vtsls", {
				capabilities = capabilities,
				settings = {
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
					javascript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {
				capabilities = capabilities,
				filetypes = { "html", "css", "javascriptreact", "typescriptreact", "astro" },
				settings = {
					tailwindCSS = {
						validate = false,
						classAttributes = { "class", "className" },
					},
				},
			})

			vim.lsp.config("biome", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			vim.lsp.config("basedpyright", {
				capabilities = capabilities,
				root_dir = function(bufnr, on_dir)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					-- Prefer git root to handle monorepos with workspace members
					local root = vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
						or vim.fs.dirname(
							vim.fs.find({ "pyproject.toml", "pyrightconfig.json" }, { path = fname, upward = true })[1]
						)
					if root then
						on_dir(root)
					end
				end,
				before_init = function(_, config)
					local venv_path = config.root_dir .. "/.venv"
					if vim.fn.isdirectory(venv_path) == 1 then
						config.settings.python = config.settings.python or {}
						config.settings.python.pythonPath = venv_path .. "/bin/python"
					end
				end,
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
						},
					},
				},
			})

			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})

			vim.lsp.config("astro", {
				capabilities = capabilities,
			})

			-- Mason setup
			require("mason").setup()

			-- Ensure formatters/linters are installed
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"prettierd",
					"prettier",
					"biome",
					"ruff",
				},
			})

			-- mason-lspconfig with automatic_enable (Neovim 0.11+ feature)
			-- This automatically calls vim.lsp.enable() for installed servers
			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {
					"vtsls",
					"tailwindcss",
					"biome",
					"lua_ls",
					"basedpyright",
					"cssls",
					"astro",
				},
			})
		end,
	},
}
