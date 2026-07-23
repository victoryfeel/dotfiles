-- === Snacks ===
if vim.g.vscode then return end

local P = {
  name = "snacks.nvim",
}

PackUtils.load(P, function()
  -- rainbow-indent variable
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
  -- AI Edit: 定义 lazygit 聚焦面板边框的高亮组（颜色需用组名，snacks 会读取其颜色写入 YAML）
  vim.api.nvim_set_hl(0, "LazyGitActiveBorder", { fg = "#50fa7b", bold = true }) -- lazygit 默认绿：当前聚焦 panel #00ff00
  
  -- AI Edit: 强制修改普通通知 (Info) 的图标和标题为绿色，默认错误 (Error) 已经是红色
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = "#50fa7b" })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = "#50fa7b" })
  vim.api.nvim_set_hl(0, "SnacksNotifierBorderInfo", { fg = "#50fa7b" })
  require("snacks").setup({
    image = {},
    -- AI Edit: 仅覆盖 activeBorderColor，其余保持 snacks 默认；fg 必须是高亮组名
    lazygit = {
      theme = {
        activeBorderColor = { fg = "LazyGitActiveBorder", bold = true }, -- 聚焦面板边框高亮
      },
    },
    notifier = {},
    picker = {
      win = {
        input = {
          keys = { -- Esc直接关闭窗口，不进入normal模式
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
    -- AI Edit: Lazygit 浮窗样式：圆角边框、尺寸比例
    styles = {
      lazygit = {
        border = "rounded", -- 圆角边框（对应旧版 border_chars）
        width  = 0.9,       -- 宽占屏幕 90%（对应旧版 scaling_factor）
        height = 0.9,       -- 高占屏幕 90%
        wo     = {
          winblend = 0,     -- 完全不透明（对应旧版 winblend = 0）
        }
      }
    }
  })
end)

local map = require("core.keymap")
map:lua("<leader>gg", "Snacks.lazygit()")
map:lua("gr", "Snacks.picker.lsp_references()")
map:lua("<leader>n", "Snacks.notifier.show_history()") -- 查看被截断的历史长消息

-- 彻底清除 Neovim 0.10+ 自带的 LSP 默认映射，解除 `gr` 的 1秒等待延迟
local default_lsp_keys = { "grr", "grn", "gra", "gri", "grt", "grx" }
for _, key in ipairs(default_lsp_keys) do
  pcall(vim.keymap.del, "n", key) -- 使用 pcall 忽略找不到映射时的报错
  pcall(vim.keymap.del, "x", key)
end

-- ======== old lazygit.nvim config ===========
-- vim.pack.add({ "https://www.github.com/kdheepak/lazygit.nvim" })
--
-- vim.g.lazygit_floating_window_winblend = 0
-- vim.g.lazygit_floating_window_scaling_factor = 0.9
-- vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
--
-- vim.keymap.set("n", "<leader>gg", "<cmd>LazyGitCurrentFile<cr>", { desc = "LazyGit (current file repo)" })
