vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
  enabled = true,
  render_modes = { "n", "c", "t" },

  heading = {
    enabled = true,
    sign = false,
    icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
  },

  code = {
    enabled = true,
    sign = false,
    style = "full",
    border = "thin",
  },

  bullet = {
    enabled = true,
    icons = { "• ", "◦ ", "◆ ", "◇ " },
  },

  checkbox = {
    enabled = true,
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },

  table = {
    enabled = true,
    border = "thin",
  },

  anti_conceal = {
    enabled = true,
  },

  completions = {
    lsp = { enabled = true },
  },
})
