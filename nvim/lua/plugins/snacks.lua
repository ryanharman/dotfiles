return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		image = { enabled = true },
		input = { enabled = true, icon = "" },
		notifier = { enabled = true },
		picker = {
			enabled = true,
			ui_select = true,
			layout = {
				preset = "default",
				layout = { width = 0.87, height = 0.80 },
			},
			sources = {
				files = {
					exclude = {
						"node_modules",
						".git",
						"dist",
						"build",
						"*.min.js",
						"*.min.mjs",
					},
				},
			},
		},
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
	},
	keys = {
		-- File / text pickers
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
		{ "<leader>fi", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "Help tags" },
		{ "<leader>ft", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
		{ "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>fl", function() Snacks.picker.lazy() end, desc = "Lazy plugins" },
		{ "<leader>fc", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>f:", function() Snacks.picker.command_history() end, desc = "Command history" },
		{ "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume last picker" },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		vim.keymap.set("n", "<C-t>", function()
			require("snacks.terminal").toggle()
		end, { desc = "Toggle Snacks Terminal" })

		vim.keymap.set("t", "<C-t>", function()
			require("snacks.terminal").toggle()
		end, { desc = "Toggle Snacks Terminal" })
	end,
}
