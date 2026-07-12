vim.pack.add({
  "https://github.com/hedyhli/outline.nvim",
})

require("outline").setup({
  outline_window = {
    position = "left",
    width = 20,
    auto_close = true,
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Outline<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>OutlineFocus<cr>")
