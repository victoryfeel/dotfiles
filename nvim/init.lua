-- 1. lua byte cache
if vim.loader then
  vim.loader.enable()
end

-- 2. core
require("alexmak.core.colorscheme")
require("alexmak.core.options")
require("alexmak.core.keymaps")

-- 3. plugins
require("alexmak.plugins.nvim-web-devicons")
require("alexmak.plugins.mini")
require("alexmak.plugins.lualine")
require("alexmak.plugins.treesitter")
require("alexmak.plugins.fzf-lua")
require("alexmak.plugins.lazygit")
require("alexmak.plugins.gitsigns")
require("alexmak.plugins.markdown")
require("alexmak.plugins.yazi")
require("alexmak.plugins.mason")
require("alexmak.plugins.lsp")
require("alexmak.plugins.outline")
