-- === 图标支持 (nvim-web-devicons) ===
local P = {
  name = "nvim-web-devicons",
  deps = {},
  build_cmd = nil,
}

-- 注册构建监听器
PackUtils.setup_listener(P.name, P.build_cmd)

-- 懒加载触发器
vim.api.nvim_create_autocmd({
  "BufReadPost", "BufNewFile", -- 界面/语法类
}, {
  once = true,
  callback = function()
    PackUtils.load(P, function()
      require("nvim-web-devicons").setup({
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh",
          },
        },
        color_icons = true,
        default = true,
        strict = true,
        variant = "light|dark",
        blend = 0,
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore",
          },
          ["README.md"] = {
            icon = "",
            color = "#519aba",
            name = "Readme",
          },
        },
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log",
          },
        },
        override_by_operating_system = {
          ["apple"] = {
            icon = "",
            color = "#A2AAAD",
            cterm_color = "248",
            name = "Apple",
          },
        },
      })
      require("nvim-web-devicons").get_icons()
    end)
  end
})

-- ==============================================================
-- AI Edit: 以下为修改前的原始配置（已注释备查）
-- ==============================================================
-- vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
--
-- require("nvim-web-devicons").setup({
--   override = {
--     zsh = {
--       icon = "",
--       color = "#428850",
--       cterm_color = "65",
--       name = "Zsh",
--     },
--   },
--   color_icons = true,
--   default = true,
--   strict = true,
--   variant = "light|dark",
--   blend = 0,
--   override_by_filename = {
--     [".gitignore"] = {
--       icon = "",
--       color = "#f1502f",
--       name = "Gitignore",
--     },
--     ["README.md"] = {
--       icon = "",
--       color = "#519aba",
--       name = "Readme",
--     },
--   },
--   override_by_extension = {
--     ["log"] = {
--       icon = "",
--       color = "#81e043",
--       name = "Log",
--     },
--   },
--   override_by_operating_system = {
--     ["apple"] = {
--       icon = "",
--       color = "#A2AAAD",
--       cterm_color = "248",
--       name = "Apple",
--     },
--   },
-- })
-- require("nvim-web-devicons").get_icons()
