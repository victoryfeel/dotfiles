-- =============================================================================
-- Performance Optimizations
-- =============================================================================
vim.filetype.add({
	extension = {
		h = "cpp",
	},
})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.opt.shada = "'20,<50,s10,h"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldmethod = "manual"
vim.opt.foldlevel = 99
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- =============================================================================
-- UI & Display
-- =============================================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
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
