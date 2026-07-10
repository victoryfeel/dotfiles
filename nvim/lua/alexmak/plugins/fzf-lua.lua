vim.pack.add({ "https://www.github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({
  defaults = {
    file_icons = "mini",
  },
})

vim.keymap.set("n", "<leader>ff", function()
  local buf_dir = vim.fn.expand("%:p:h")
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(buf_dir) .. " rev-parse --show-toplevel")[1]
  require("fzf-lua").files({ cwd = vim.v.shell_error == 0 and git_root or buf_dir })
end)
