vim.keymap.set("n", "<leader>kk", function()
	if not package.loaded["yazi"] then
		vim.pack.add({
			"https://github.com/nvim-lua/plenary.nvim",
			"https://github.com/mikavilpas/yazi.nvim",
		})
		require("yazi").setup({
			open_for_directories = false,
		})
	end
	require("yazi").yazi()
end, { desc = "Toggle Yazi file manager" })
