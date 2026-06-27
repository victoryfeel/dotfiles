vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
})
vim.cmd("packadd nvim-web-devicons")

require("nvim-web-devicons").setup({
	color_icons = true,
	default = true,
})