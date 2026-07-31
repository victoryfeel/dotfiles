-- Markdown 专属配置与渲染插件 (after/ftplugin/markdown.lua)
-- AI Edit: 使用 vim.schedule 延后渲染排版，避免打开 .md 文件时同步扫描全页 Treesitter 节点造成卡顿

vim.schedule(function()
  if not package.loaded["render-markdown"] then
    vim.pack.add({
      "https://github.com/nvim-treesitter/nvim-treesitter",
      "https://github.com/nvim-tree/nvim-web-devicons",
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
  end
end)
