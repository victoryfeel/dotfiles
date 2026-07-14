vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

vim.opt.list = true
vim.opt.listchars = {
  lead = "·",
  trail = "·",
  nbsp = "␣",
  tab = "→ ",
}

vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#5e5738" })
vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#3c5f4e" })
vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#5e4568" })
vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#375768" })

require("snacks").setup({
  indent = {
    indent = {
      char = "│",
      hl = {
        "SnacksIndent1",
        "SnacksIndent2",
        "SnacksIndent3",
        "SnacksIndent4",
      },
    },
    scope = {
      enabled = false,
    },
    animate = {
      enabled = false,
    },
  },
})
