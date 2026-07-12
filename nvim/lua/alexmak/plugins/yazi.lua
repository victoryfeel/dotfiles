vim.pack.add({
  "https://www.github.com/nvim-lua/plenary.nvim",
  "https://www.github.com/mikavilpas/yazi.nvim",
})

require("yazi").setup({
  open_for_directories = false,
})

vim.keymap.set("n", "<leader>kk", "<cmd>Yazi<cr>")
