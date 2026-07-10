vim.pack.add({ "https://www.github.com/kdheepak/lazygit.nvim" })

vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.9
vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGitCurrentFile<cr>", { desc = "LazyGit (current file repo)" })
