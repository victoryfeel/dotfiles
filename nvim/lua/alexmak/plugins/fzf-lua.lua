vim.pack.add({ "https://www.github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require("fzf-lua").files({ cwd = vim.v.shell_error == 0 and git_root or nil })
end)
