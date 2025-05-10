local jestConfigFile = function(file)
	if string.find(file, "/packages/") then
		return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
	end

	return vim.fn.getcwd() .. "/jest.config.ts"
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	keys = {
		{ "<leader>ta", "<CMD>Neotest run<CR>", mode = "n", desc = "Neotest" },
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			mode = "n",
			desc = "Neotest File",
		},
		{ "<leader>tw", "<CMD>Neotest watch<CR>", mode = "n", desc = "Neotest Watch" },
		{ "<leader>ts", "<CMD>Neotest summary<CR>", mode = "n", desc = "Neotest Summary" },
		{ "<leader>to", "<CMD>Neotest output<CR>", mode = "n", desc = "Neotest Output" },
		{ "<leader>tc", "<CMD>Neotest cancel<CR>", mode = "n", desc = "Neotest Cancel" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				-- require("neotest-jest")({
				-- 	jestCommand = "npx jest --coverage --maxWorkers=4",
				-- 	-- jestConfigFile = jestConfigFile(vim.fn.getcwd()),
				-- }),
				require("neotest-vitest")({}),
			},
		})
	end,
}
