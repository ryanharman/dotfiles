-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("hide_message_after_write", { clear = true }),
	desc = "Get rid of message after writing a file",
	pattern = { "*" },
	command = "redrawstatus",
})

-- Stop LSP clients on non-file buffers (diffview://, fugitive://, gitsigns://)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_detach_non_file_bufs", { clear = true }),
	callback = function(args)
		local name = vim.api.nvim_buf_get_name(args.buf)
		if name:match("^%w+://") then
			vim.schedule(function()
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client then
					client:stop()
				end
			end)
		end
	end,
})
