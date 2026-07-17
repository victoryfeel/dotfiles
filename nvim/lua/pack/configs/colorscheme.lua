-- === dracula official theme ===
-- if vim.g.vscode then return end

local P = {
  name = "dracula.nvim",
}

PackUtils.load(P, function()
  require("dracula").setup({
    transparent_bg = true,
    italic_comment = true,
  })
  vim.cmd.colorscheme("dracula")
end)
