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
