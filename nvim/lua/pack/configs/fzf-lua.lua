-- === fzf-lua ===
local P = {
  name = "fzf-lua",
}

vim.keymap.set("n", "<leader>ff", function()
  PackUtils.load(P, function()
    require("fzf-lua").setup({})
  end)

  local buf_dir = vim.fn.expand("%:p:h")
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(buf_dir) .. " rev-parse --show-toplevel")[1]
  require("fzf-lua").files({ cwd = vim.v.shell_error == 0 and git_root or buf_dir })
end, { desc = "Fuzzy find files" })
