vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})
vim.cmd("packadd lualine.nvim")

require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    icons_enabled = true,
  },
})

