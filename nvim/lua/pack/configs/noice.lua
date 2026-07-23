--=========  Popup UI Customized  =========--
local P = {
  name = "noice.nvim",
  deps = { "nui.nvim" },
  build_cmd = nil,
}

--=========================================--
--=========  No Needed lazy-load  =========--
--=========================================--
PackUtils.load(P, function()
  require("noice").setup({
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
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
    -- 需要过滤的信息
    routes = {
      {
        -- 过滤打开rust文件不影响使用的错误提示
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
