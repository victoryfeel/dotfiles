local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text briefly for visual feedback
autocmd("TextYankPost", {
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Restore last cursor position when reopening a file
autocmd("BufReadPost", {
	group = augroup("RestoreCursor", { clear = true }),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Auto-split direction for help documentation based on window width (wide screen: right, narrow: bottom)
autocmd("FileType", {
	group = augroup("HelpSplitDirection", { clear = true }),
	pattern = "help",
	callback = function()
		if vim.api.nvim_win_get_width(0) >= 120 then
			vim.cmd("wincmd L")
		else
			vim.cmd("wincmd J")
		end
	end,
})

-- turn off options when open float terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("DisableTerminalUI", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.cursorline = false
	end,
})

-- Auto-save: write buffer on focus loss, idle, or leaving insert mode
autocmd({ "FocusLost", "BufLeave", "InsertLeave", "TextChanged" }, {
	group = augroup("AutoSave", { clear = true }),
	callback = function(args)
		local buf = args.buf
		if
			vim.bo[buf].modified
			and vim.bo[buf].buftype == ""
			and vim.bo[buf].modifiable
			and vim.api.nvim_buf_get_name(buf) ~= ""
		then
			vim.api.nvim_buf_call(buf, function()
				vim.cmd("silent! write")
			end)
		end
	end,
})

-- Persist nvim session file for tmux-resurrect recovery
autocmd({ "VimLeavePre", "BufWritePost" }, {
	group = augroup("SessionPersist", { clear = true }),
	callback = function()
		-- Only save if at least one real file buffer exists
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[buf].buflisted and vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
				vim.cmd("silent! mksession!")
				return
			end
		end
	end,
})
