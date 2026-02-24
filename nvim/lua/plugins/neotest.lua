local function file_exists(path)
	local file = io.open(path, "r")
	if file then
		io.close(file)
		return true
	end
	return false
end

local function find_workspace_packages(start_dir)
	local workspace_file = start_dir .. "/pnpm-workspace.yaml"
	
	if not file_exists(workspace_file) then
		return nil, {}
	end
	
	local packages = {}
	local content = vim.fn.readfile(workspace_file)
	local in_packages = false
	
	for _, line in ipairs(content) do
		if line:match("^packages:") then
			in_packages = true
		elseif in_packages and line:match("^%s*-") then
			-- Match quoted ('...', "...") or unquoted package patterns
			local pattern = line:match("^%s*-%s*['\"]?([^'\"]+)['\"]?%s*$")
			if pattern then
				local glob_pattern = start_dir .. "/" .. pattern
				local dirs = vim.fn.glob(glob_pattern, false, true)
				for _, dir in ipairs(dirs) do
					table.insert(packages, dir)
				end
			end
		elseif in_packages and line:match("^[^%s]") then
			break
		end
	end
	
	return start_dir, packages
end

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
				return true
			end
		end
	end
	
	local workspace_root, packages = find_workspace_packages(directory)
	if workspace_root then
		for _, pkg_dir in ipairs(packages) do
			for _, file in ipairs(config_files) do
				local full_path = pkg_dir .. "/" .. file
				if file_exists(full_path) then
					if file == "package.json" and package_json_key then
						local package_json_content = vim.fn.readfile(full_path)
						local success, decoded_json = pcall(vim.json.decode, table.concat(package_json_content, "\n"))
						if success and decoded_json and decoded_json[package_json_key] then
							return true
						end
					elseif file ~= "package.json" or not package_json_key then
						return true
					end
				end
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
		"vitest.config.mts",
		"vitest.config.mjs",
		"vitest.config.cjs",
	}
	local has_vitest = has_config(current_dir, vitest_config_files) -- No specific package.json key for Vitest by default

	if has_jest then
		table.insert(
			adapters,
			require("neotest-jest")({
				jestCommand = "npx jest --coverage --maxWorkers=4",
			})
		)
		vim.notify("Neotest: Using Jest adapter", vim.log.levels.INFO, { title = "Neotest" })
	end

	if has_vitest then
		local vitest_config_patterns = {
			"vitest.config.ts",
			"vitest.config.mts",
			"vitest.config.js",
			"vitest.config.mjs",
			"vitest.config.cjs",
		}

		table.insert(adapters, require("neotest-vitest")({
			vitestCommand = "pnpm vitest",
			cwd = function(path)
				return require("lspconfig.util").root_pattern(unpack(vitest_config_patterns))(path)
			end,
			vitestConfigFile = function(path)
				local root = require("lspconfig.util").root_pattern(unpack(vitest_config_patterns))(path)
				if root then
					for _, config_file in ipairs(vitest_config_patterns) do
						local config_path = root .. "/" .. config_file
						if file_exists(config_path) then
							return config_path
						end
					end
				end
				return nil
			end,
		}))
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
