vim.pack.add({
  "https://github.com/Mofiqul/dracula.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/nvim-mini/mini.indentscope",
})

require("dracula").setup({
  transparent_bg = true,
  italic_comment = true,
})

vim.cmd.colorscheme("dracula")
