-- ====== event trigger ====== --
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
			require("gitsigns").setup({})
		end)
	end,
})
