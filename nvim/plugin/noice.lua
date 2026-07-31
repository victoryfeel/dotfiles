-- AI Edit: 使用 vim.schedule 延后 Noice UI 渲染框架初始化，避开首屏同步渲染 (节省 ~2.5ms)
vim.schedule(function()
  vim.pack.add({
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/folke/noice.nvim",
  })

  require("noice").setup({
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      hover = {
        enabled = true,
      },
      signature = {
        enabled = false,
      },
    },
    notify = {
      enabled = false, -- 禁用 Noice 的弹窗，交由更专业的 snacks.notifier 处理
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        win_options = {
          winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
        },
      },
      cmdline_popupmenu = {
        relative = "editor",
        position = {
          row = "54%", -- 让 popupmenu 紧贴在居中的 cmdline 下方
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
        },
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "emsg",
          find = "Error in decoration provider",
        },
        opts = { skip = true },
      },
    },
  })
end)
