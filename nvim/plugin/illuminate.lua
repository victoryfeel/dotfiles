vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/RRethy/vim-illuminate" })
    require("illuminate").configure({})
  end
})
