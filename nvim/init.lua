-- 1. lua byte cache
if vim.loader then
  vim.loader.enable()
end

-- 2. core
require("alexmak.core.colorscheme")
require("alexmak.core.options")
require("alexmak.core.keymaps")

-- 3. plugins
require("alexmak.plugins.web-devicons")
require("alexmak.plugins.lualine")
require("alexmak.plugins.treesitter")
require("alexmak.plugins.nvim-tree")
require("alexmak.plugins.fzf-lua")
require("alexmak.plugins.mini")
require("alexmak.plugins.gitsigns")
require("alexmak.plugins.mason")
require("alexmak.plugins.lsp")
