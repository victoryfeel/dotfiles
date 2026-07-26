--================================--
--=========  Auto Pairs  =========--
--================================--
local P = {
  name = "nvim-autopairs",
  deps = {},
  build_cmd = nil,
}

-- Set Build Listener
PackUtils.setup_listener(P.name, P.build_cmd)
--==============================================--
--=========  lazy-load: event trigger  =========--
--==============================================--
vim.api.nvim_create_autocmd({
  "InsertEnter",
}, {
  once = true,
  callback = function()
    PackUtils.load(P, function()
      require('nvim-autopairs').setup({
        disable_filetype = { "markdown" },
        check_ts = true,
      })
    end)
  end
})
