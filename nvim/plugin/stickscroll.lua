--========= sticky context =========--
vim.api.nvim_create_autocmd({
  "FileType"
}, {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context" })
    require("treesitter-context").setup({
      enable = true,
      multiwindow = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = "─",
      zindex = 20,
    })
    vim.keymap.set("n", "[c", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true })
  end,
})
