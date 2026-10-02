-- Lockfile -> command prefix for running a package binary, in priority order
-- (checked within the nearest directory that contains any lockfile)
local package_runners = {
	{ "pnpm-lock.yaml", "pnpm" },
	{ "bun.lock", "bun run" },
	{ "bun.lockb", "bun run" },
	{ "yarn.lock", "yarn" },
	{ "package-lock.json", "npx" },
}

local lockfiles = vim.tbl_map(function(entry)
	return entry[1]
end, package_runners)

-- Resolve the package manager per test file, so monorepos and switching projects just work
local function package_runner(path)
	-- Nested list = equal priority, so the nearest lockfile wins (not the first marker)
	local root = vim.fs.root(path, { lockfiles })
	if root then
		for _, entry in ipairs(package_runners) do
			if vim.uv.fs_stat(vim.fs.joinpath(root, entry[1])) then
				return entry[2]
			end
		end
	end
	return "npx"
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	keys = {
		{ "<leader>ts", "<CMD>Neotest summary<CR>", mode = "n", desc = "Neotest Summary" },
		{ "<leader>to", "<CMD>Neotest output<CR>", mode = "n", desc = "Neotest Output" },
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			mode = "n",
			desc = "Neotest File",
		},
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			mode = "n",
			desc = "Neotest Run Nearest (it/test block)",
		},
	},
	config = function()
		require("neotest").setup({
			-- Both adapters are always registered; each only claims test files whose
			-- package.json (or monorepo root package.json) depends on jest/vitest.
			-- vitest resolves its own cwd and config file from the nearest vite/vitest config.
			adapters = {
				require("neotest-jest")({
					jestCommand = function(path)
						return package_runner(path) .. " jest --maxWorkers=4"
					end,
				}),
				require("neotest-vitest")({
					vitestCommand = function(path)
						return package_runner(path) .. " vitest"
					end,
				}),
			},
			output = {
				enabled = true,
				open_on_run = "errors",
				floating = true,
			},
		})
	end,
}
