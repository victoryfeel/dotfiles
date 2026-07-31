-- ====== event trigger ====== --
-- AI Edit: 使用 vim.schedule 延后 gitsigns 加载，避开文件打开时的同步线程阻塞
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
      require('gitsigns').setup {}
    end)
  end,
})
