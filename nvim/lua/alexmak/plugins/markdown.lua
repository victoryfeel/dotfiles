vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
require("render-markdown").setup({
  heading = {
    position = "inline",
    border = true,
    border_virtual = true,
  },
})
