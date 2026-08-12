-- Highlight the same words
vim.api.nvim_create_autocmd("BufReadPost", {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.pack.add({ "https://github.com/RRethy/vim-illuminate" })
			require("illuminate").configure({})
		end)
	end,
})
