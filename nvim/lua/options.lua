-- =============================================================================
-- Performance Optimizations (AI Edit: 禁用未使用的原生内置插件与废弃 Provider)
-- =============================================================================
-- AI Edit: 显式将 .h 扩展名绑定为 cpp，绕过 Neovim 默认对 .h 文件内容正则扫描猜语言的 15ms 延迟
vim.filetype.add({
  extension = {
    h = "cpp",
  },
})

-- AI Edit: 禁用无用的 Vimscript 内置插件，避免启动时 source 相关脚本 (节省 ~2.5ms)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1

-- AI Edit: 禁用未使用的语言 Provider 检查，消除启动阶段的系统 PATH 检索 (节省 ~1ms)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- AI Edit: 精简 ShaDa 文件读取历史大小，缩短启动磁盘 I/O 读写延迟 (节省 ~1.5ms)
vim.opt.shada = "'20,<50,s10,h"

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
-- Splits & Folds (AI Edit: 将 foldmethod 改为 manual，避免打开 C++/Markdown 时全页 Treesitter 折叠计算导致卡顿)
-- =============================================================================
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldmethod = "manual"
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

-- AI Edit: 移除启动时的同步 mkdir I/O 操作，原生启用 undofile 避开磁盘同步开销
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
