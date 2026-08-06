-- OPTIMIZATION: Defer illuminate plugin loading with vim.schedule to unblock UI render
vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.pack.add({ "https://github.com/RRethy/vim-illuminate" })
      require("illuminate").configure({})
    end)
  end
})

