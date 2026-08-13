local float_term_state = { buf = nil, win = nil }

local function open_float_terminal()
	local width = math.floor(vim.o.columns * 0.80)
	local height = math.floor(vim.o.lines * 0.80)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	-- Reuse existing terminal buffer
	if float_term_state.buf and vim.api.nvim_buf_is_valid(float_term_state.buf) then
		float_term_state.win = vim.api.nvim_open_win(float_term_state.buf, true, win_opts)
		vim.wo[float_term_state.win].winblend = 0
		vim.wo[float_term_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
		vim.cmd("startinsert")
		return
	end

	local buf_dir = vim.fn.expand("%:p:h")

	float_term_state.buf = vim.api.nvim_create_buf(false, true)
	vim.bo[float_term_state.buf].bufhidden = "hide"

	float_term_state.win = vim.api.nvim_open_win(float_term_state.buf, true, win_opts)

	vim.wo[float_term_state.win].winblend = 0
	vim.wo[float_term_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	vim.fn.jobstart(vim.o.shell, {
		term = true,
		cwd = buf_dir,
		on_exit = function()
			float_term_state.buf = nil
			float_term_state.win = nil
		end,
	})
	vim.cmd("startinsert")

	-- Pressing <Esc> in terminal mode hides window without killing shell
	vim.keymap.set("t", "<Esc>", function()
		if float_term_state.win and vim.api.nvim_win_is_valid(float_term_state.win) then
			vim.api.nvim_win_close(float_term_state.win, false)
			float_term_state.win = nil
		end
	end, { buffer = float_term_state.buf, desc = "Close float terminal" })

	-- Auto-close on buffer leave
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = float_term_state.buf,
		callback = function()
			if float_term_state.win and vim.api.nvim_win_is_valid(float_term_state.win) then
				vim.api.nvim_win_close(float_term_state.win, false)
				float_term_state.win = nil
			end
		end,
	})
end

local function toggle_float_terminal()
	if float_term_state.win and vim.api.nvim_win_is_valid(float_term_state.win) then
		vim.api.nvim_win_close(float_term_state.win, false)
		float_term_state.win = nil
	else
		open_float_terminal()
	end
end

vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_float_terminal, { desc = "Toggle float terminal" })
