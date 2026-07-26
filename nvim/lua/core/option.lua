-- =============================================================================
-- UI & Display
-- =============================================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
--vim.opt.colorcolumn = "100"
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.fillchars = { eob = " " }

-- =============================================================================
-- Formatting & Indentation
-- =============================================================================
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- =============================================================================
-- Search
-- =============================================================================
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- =============================================================================
-- Splits & Folds
-- =============================================================================
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- =============================================================================
-- Completion & Menus
-- =============================================================================
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.wildmode = "longest:full,full"

-- =============================================================================
-- System & Behavior
-- =============================================================================
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")

-- =============================================================================
-- Diff, Backups & Undo
-- =============================================================================
vim.opt.diffopt:append("linematch:60")

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir
