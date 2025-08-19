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
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		-- Keymap: Toggle Snacks terminal with <C-t>
		vim.keymap.set("n", "<C-t>", function()
			require("snacks.terminal").toggle()
		end, { desc = "Toggle Snacks Terminal" })
		
		-- Keymap: Close terminal from terminal mode with <C-t>
		vim.keymap.set("t", "<C-t>", function()
			require("snacks.terminal").toggle()
		end, { desc = "Toggle Snacks Terminal" })
	end,
}
