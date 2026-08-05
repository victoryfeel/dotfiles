vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Insert Mode
-- =============================================================================
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- =============================================================================
-- Normal Mode - Navigation & Editing
-- =============================================================================
-- Wrap-aware j/k movement
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })

vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

-- Fast cursor movement and centering
vim.keymap.set("n", "J", "5jzz")
vim.keymap.set("n", "K", "5kzz")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Entire buffer file operations
vim.keymap.set("n", "yae", "ggVGy", { desc = "Yank entire file" })
vim.keymap.set("n", "dae", "ggVGd", { desc = "Delete entire file" })
vim.keymap.set("n", "cae", "ggVGc", { desc = "Change entire file" })

-- Join lines while keeping cursor position
vim.keymap.set("n", "<leader>jo", "mzJ`z", { desc = "Join lines keeping cursor pos" })

-- Save and quit (AI Edit: Use efficient <cmd> syntax)
vim.keymap.set("n", "S", "<cmd>w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "Q", "<cmd>q<CR>", { silent = true, desc = "Quit window" })

-- Clear search highlight and dismiss notifications
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><cmd>Noice dismiss<CR>", { silent = true })
vim.keymap.set("n", "<leader><CR>", "<cmd>nohlsearch<CR>", { silent = true })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Window splits and layout toggles (AI Edit: Modern <cmd> syntax)
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { silent = true, desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { silent = true, desc = "Horizontal split" })
vim.keymap.set(
	"n",
	"<leader>wv",
	"<C-w>t<C-w>H",
	{ noremap = true, silent = true, desc = "Convert to vertical split layout" }
)
vim.keymap.set(
	"n",
	"<leader>wh",
	"<C-w>t<C-w>K",
	{ noremap = true, silent = true, desc = "Convert to horizontal split layout" }
)

-- Window resize
vim.keymap.set("n", "<C-M-k>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-M-j>", "<cmd>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-M-h>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-M-l>", "<cmd>vertical resize +2<CR>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Buffer navigation
vim.keymap.set("n", "<leader>th", "<cmd>bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>tl", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })

-- Copy full file path to clipboard
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

-- Toggle diagnostic display
vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- =============================================================================
-- Visual Mode
-- =============================================================================
vim.keymap.set("v", "J", "5j", { desc = "Fast move down" })
vim.keymap.set("v", "K", "5k", { desc = "Fast move up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- =============================================================================
-- dev keymap
-- =============================================================================
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle commentline" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle commentselection" })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle commentline" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle commentselection" })

-- =============================================================================
-- Float Terminal
-- =============================================================================
local float_term_state = { buf = nil, win = nil }

local function open_float_terminal()
	local width = math.floor(vim.o.columns * 0.85)
	local height = math.floor(vim.o.lines * 0.80)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Reuse existing terminal buffer
	if float_term_state.buf and vim.api.nvim_buf_is_valid(float_term_state.buf) then
		float_term_state.win = vim.api.nvim_open_win(float_term_state.buf, true, {
			relative = "editor",
			width = width,
			height = height,
			row = row,
			col = col,
			style = "minimal",
			border = "rounded",
		})
		vim.cmd("startinsert")
		return
	end

	local buf_dir = vim.fn.expand("%:p:h")

	float_term_state.buf = vim.api.nvim_create_buf(false, true)
	float_term_state.win = vim.api.nvim_open_win(float_term_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

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
