vim.pack.add({
	"https://www.github.com/ibhagwan/fzf-lua",
})
vim.cmd("packadd fzf-lua")

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	require("fzf-lua").files({ cwd = vim.v.shell_error == 0 and git_root or nil })
end, { desc = "FZF Files (git root)" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })