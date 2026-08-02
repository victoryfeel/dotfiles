-- ======  event trigger  ====== --
vim.api.nvim_create_autocmd({ "InsertEnter", }, {
  callback = function()
    vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
    require('nvim-autopairs').setup({
      disable_filetype = { "TelescopePrompt", "markdown" },
      check_ts = true,
    })
  end,
  once = true,
})
