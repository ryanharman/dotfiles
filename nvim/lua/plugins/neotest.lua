-- Helper function to check if a file exists
local function file_exists(path)
	local file = io.open(path, "r")
	if file then
		io.close(file)
		return true
	end
	return false
end

--- Checks for the existence of any file from a given list within a directory.
--- Special handling for package.json to check for a specific key.
--- @param directory string The directory to check within.
--- @param config_files table A list of file names to check for.
--- @param package_json_key string|nil An optional key to check in package.json.
--- @return boolean True if any of the config files are found (and package.json has the key if specified), false otherwise.
local function has_config(directory, config_files, package_json_key)
	for _, file in ipairs(config_files) do
		local full_path = directory .. "/" .. file
		if file_exists(full_path) then
			if file == "package.json" and package_json_key then
				local package_json_content = vim.fn.readfile(full_path)
				local success, decoded_json = pcall(vim.json.decode, table.concat(package_json_content, "\n"))
				if success and decoded_json and decoded_json[package_json_key] then
					return true
				end
			elseif file ~= "package.json" or not package_json_key then
				-- If it's not package.json, or if it is package.json but we don't
				-- care about a specific key, then just its existence is enough.
				return true
			end
		end
	end
	return false
end

-- Helper function to determine which test adapters to load
local function get_test_adapters()
	local adapters = {}
	local current_dir = vim.fn.getcwd()

	-- Define Jest config files and package.json key
	local jest_config_files = {
		"jest.config.js",
		"jest.config.ts",
		"jest.config.mjs",
		"jest.config.cjs",
		"package.json",
	}
	local has_jest = has_config(current_dir, jest_config_files, "jest")

	-- Define Vitest config files
	local vitest_config_files = {
		"vitest.config.js",
		"vitest.config.ts",
		"vitest.config.mjs",
		"vitest.config.cjs",
	}
	local has_vitest = has_config(current_dir, vitest_config_files) -- No specific package.json key for Vitest by default

	if has_jest then
		table.insert(
			adapters,
			require("neotest-jest")({
				jestCommand = "npx jest --coverage --maxWorkers=4",
				-- jestConfigFile = "jest.config.js", -- Uncomment if needed
			})
		)
		vim.notify("Neotest: Using Jest adapter", vim.log.levels.INFO, { title = "Neotest" })
	end

	if has_vitest then
		table.insert(
			adapters,
			require("neotest-vitest")({
				-- vitestCommand = "npm test --", -- Uncomment if needed
			})
		)
		vim.notify("Neotest: Using Vitest adapter", vim.log.levels.INFO, { title = "Neotest" })
	end

	if not has_jest and not has_vitest then
		vim.notify(
			"Neotest: No Jest or Vitest config found. No test adapter loaded.",
			vim.log.levels.WARN,
			{ title = "Neotest" }
		)
	end

	return adapters
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
		-- {
		-- 	"<leader>tn",
		-- 	function()
		-- 		-- This attempts to run the nearest test.
		-- 		-- Requires Treesitter parsers for your language (JS/TS)
		-- 		require("neotest").run.run_nearest()
		-- 	end,
		-- 	mode = "n",
		-- 	desc = "Neotest Run Nearest (it/test block)",
		-- },
		-- {
		-- 	"<leader>td",
		-- 	function()
		-- 		-- Debug the nearest test. Requires nvim-dap and a DAP adapter.
		-- 		require("neotest").run.run_nearest({ strategy = "dap" })
		-- 	end,
		-- 	mode = "n",
		-- 	desc = "Neotest Debug Nearest",
		-- },
	},
	config = function()
		require("neotest").setup({
			adapters = get_test_adapters(),
			output = {
				enabled = true,
				open_on_run = "errors",
				floating = true,
			},
			project_root = function(start_path)
				return require("lspconfig.util").root_pattern("package.json", ".git", "node_modules")(start_path)
			end,
			-- dap = {
			-- 	enabled = true,
			-- },
		})
	end,
}
