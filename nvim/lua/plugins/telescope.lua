return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim", "tsakirist/telescope-lazy.nvim", "andrew-george/telescope-themes" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fi", builtin.live_grep, { desc = "Telescope find in files" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set("n", "<leader>ft", ":Telescope themes<CR>", { desc = "Telescope find themes" })

		require("telescope").setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				file_ignore_patterns = { "node_modules" },
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			},
			extensions = {
				-- Type information can be loaded via 'https://github.com/folke/lazydev.nvim'
				-- by adding the below two annotations:
				---@module "telescope._extensions.lazy"
				---@type TelescopeLazy.Config
				lazy = {
					-- Optional theme (the extension doesn't set a default theme)
					-- theme = "ivy",
					-- The below configuration options are the defaults
					show_icon = true,
					mappings = {
						open_in_browser = "<C-o>",
						open_in_file_browser = "<M-b>",
						open_in_find_files = "<C-f>",
						open_in_live_grep = "<C-g>",
						open_in_terminal = "<C-t>",
						open_plugins_picker = "<C-b>",
						open_lazy_root_find_files = "<C-r>f",
						open_lazy_root_live_grep = "<C-r>g",
						change_cwd_to_plugin = "<C-c>d",
					},
					actions_opts = {
						open_in_browser = {
							auto_close = false,
						},
						change_cwd_to_plugin = {
							auto_close = false,
						},
					},
					terminal_opts = {
						relative = "editor",
						style = "minimal",
						border = "rounded",
						title = "Telescope lazy",
						title_pos = "center",
						width = 0.5,
						height = 0.5,
					},
					-- Other telescope configuration options
				},
			},
		})

		require("telescope").load_extension("lazy")
		require("telescope").load_extension("themes")
	end,
}

