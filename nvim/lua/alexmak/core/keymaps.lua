vim.g.mapleader = " "
vim.g.maplocalleader = " "

--================================================
--=============== insert mode  ===================
--================================================
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

--================================================
--=============== normal mode  ===================
--================================================
-- better navigation
vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

vim.keymap.set("n", "J", "5jzz")
vim.keymap.set("n", "K", "5kzz")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "yae", "ggVGy")
vim.keymap.set("n", "dae", "ggVGd")
vim.keymap.set("n", "cae", "ggVGc")
-- join lines and keep cursor position
vim.keymap.set("n", "<leader>jo", "mzJ`z")
-- save and quit
vim.keymap.set("n", "S", ":w<CR>")
vim.keymap.set("n", "Q", ":q<CR>")
-- search
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- split windows and switch focus
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
vim.keymap.set("n", "sv", "<C-w>t<C-w>H", { noremap = true, silent = true, desc = "上下互换" })
vim.keymap.set("n", "sh", "<C-w>t<C-w>K", { noremap = true, silent = true, desc = "左右互换" })

vim.keymap.set("n", "<C-M-k>", ":resize +2<CR>")
vim.keymap.set("n", "<C-M-j>", ":resize -2<CR>")
vim.keymap.set("n", "<C-M-h>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-M-l>", ":vertical resize +2<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- tab switch
vim.keymap.set("n", "th", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "tl", ":bnext<CR>", { desc = "Next buffer" })

-- <leader>+pa to copy current file full path
vim.keymap.set("n", "<leader>pa", function() -- show file path
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

--================================================
--=============== visual mode  ===================
--================================================
vim.keymap.set("v", "J", "5j", { desc = "Fast move down" })
vim.keymap.set("v", "K", "5k", { desc = "Fast move up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

--================================================
--=============== float terminal  ================
--================================================
local float_term_state = { buf = nil, win = nil }

local function open_float_terminal()
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.80)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- reuse buffer if it still exists
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

  -- AI 编辑: 在创建新窗口前获取路径，否则 % 会指向新 buffer
  local buf_dir = vim.fn.expand("%:p:h")

  -- create new buffer and terminal
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
  vim.fn.termopen(vim.o.shell, {
    cwd = buf_dir,
    on_exit = function()
      float_term_state.buf = nil
      float_term_state.win = nil
    end,
  })
  vim.cmd("startinsert")

  -- <Esc> closes the float window (without killing the shell)
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

vim.keymap.set({ "n", "t" }, "<leader>t", toggle_float_terminal, { desc = "Toggle float terminal" })
