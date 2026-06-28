-- =========================================================
-- ================= UI & Display (界面与显示) =============
-- =========================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true         -- highlight current line
vim.opt.signcolumn = "yes"        -- always show a sign column
vim.opt.colorcolumn = "100"       -- show a column at 100 position chars
vim.opt.showmode = false          -- do not show the mode, instead have it in statusline
vim.opt.cmdheight = 0             -- hide command line unless needed
vim.opt.showmatch = true          -- highlights matching brackets
vim.opt.conceallevel = 0          -- do not hide markup
vim.opt.concealcursor = ""        -- do not hide cursorline in markup
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- =========================================================
-- ================= Indent & Format (缩进与格式) ==========
-- =========================================================
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true
vim.opt.autoindent = true

-- =========================================================
-- ================= Search (搜索) =========================
-- =========================================================
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- =========================================================
-- ================= Split & Fold (分屏与折叠) =============
-- =========================================================
vim.opt.splitbelow = true                            -- horizontal splits go below
vim.opt.splitright = true                            -- vertical splits go right
vim.opt.foldmethod = "expr"                          -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99                               -- start with all folds open

-- =========================================================
-- ================= Menu & Completion (补全与菜单) ========
-- =========================================================
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.pumheight = 10                            -- popup menu height
vim.opt.pumblend = 10                             -- popup menu 10% transparency
vim.opt.winblend = 0                              -- floating window 0% transparency
vim.opt.wildmenu = true                           -- tab completion
vim.opt.wildmode = "longest:full,full"            -- complete longest common match, full completion list

-- =========================================================
-- ================= System & Behavior (系统与行为) ========
-- =========================================================
vim.opt.updatetime = 300                -- faster completion
vim.opt.timeoutlen = 500                -- timeout duration
vim.opt.ttimeoutlen = 50                -- key code timeout
vim.opt.autoread = true                 -- auto-reload changes if outside of neovim
vim.opt.autowrite = false               -- do not auto-save
vim.opt.hidden = true                   -- allow hidden buffers
vim.opt.errorbells = false              -- no error sounds
vim.opt.backspace = "indent,eol,start"  -- better backspace behaviour
vim.opt.autochdir = false               -- do not autochange directories
vim.opt.iskeyword:append("-")           -- include "-" in words
vim.opt.path:append("**")               -- include subdirs in search
vim.opt.selection = "inclusive"         -- include last char in selection
vim.opt.mouse = "a"                     -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true               -- allow buffer modifications
vim.opt.encoding = "utf-8"              -- set encoding

-- =========================================================
-- ================= Performance & Diff (性能与差异比对) ===
-- =========================================================
vim.opt.lazyredraw = true              -- do not redraw during macros
vim.opt.synmaxcol = 300                -- syntax highlighting limit, 长>300的代码后面不再渲染，防止卡顿
vim.opt.redrawtime = 10000             -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000          -- increase max memory
vim.opt.diffopt:append("linematch:60") -- improve diff display

-- =========================================================
-- ================= Undo & Backup (撤销与备份) ============
-- =========================================================
-- Persistent undo: 重启server后仍可undo上次编辑的内容
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.backup = false      -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false    -- do not create a swapfile
vim.opt.undofile = true     -- do create an undo file
vim.opt.undodir = undodir   -- set the undo directory
