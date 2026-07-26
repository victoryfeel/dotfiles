--=========  dev icons  =========--
local P = {
  name = "nvim-web-devicons",
  deps = {},
  build_cmd = nil,
}

--==============================================--
--=========  lazy-load: event trigger  =========--
--==============================================--
vim.api.nvim_create_autocmd({
  "BufReadPost", "BufNewFile",
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
