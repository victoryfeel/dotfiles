vim.pack.add({ "https://github.com/folke/snacks.nvim" })

-- rainbow-indent
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
-- lazygit
vim.api.nvim_set_hl(0, "LazyGitActiveBorder", { fg = "#50fa7b", bold = true }) -- lazygit 默认绿：当前聚焦 panel #00ff00
-- notification
vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = "#50fa7b" })
vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = "#50fa7b" })
vim.api.nvim_set_hl(0, "SnacksNotifierBorderInfo", { fg = "#50fa7b" })

require("snacks").setup({
  image = {},
  lazygit = {
    theme = {
      activeBorderColor = { fg = "LazyGitActiveBorder", bold = true },
    },
  },
  notifier = {},
  picker = {
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<c-e>"] = { "list_down", mode = { "i", "n" } },
          ["<c-u>"] = { "list_up", mode = { "i", "n" } },
        }
      }
    }
  },
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
  styles = {
    lazygit = {
      border = "rounded",
      width  = 0.9,
      height = 0.9,
      wo     = {
        winblend = 0,
      }
    }
  },
})

local Snacks = require("snacks")
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end)
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end)
vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end)
