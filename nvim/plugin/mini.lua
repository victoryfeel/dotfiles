vim.api.nvim_create_autocmd({ "VimEnter" }, {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })
    require('mini.surround').setup {
      mappings = {
        add = 's',
        delete = 'sd',
        replace = 'cs',
      },
    }
  end
})
