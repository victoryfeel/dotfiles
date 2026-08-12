vim.api.nvim_create_autocmd({ "VimEnter" }, {
	once = true,
	callback = function()
		vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })
		--=========  mini.surround  =========--
		require("mini.surround").setup({
			--  s/sd/sc in word
			mappings = {
				add = "s", -- s" to add " surround selected text
				delete = "sd", -- "temp text", sd" to delete " when cursor in ""
				replace = "sr", -- "temp text", sr'" to replace ' with "
			},
			silent = true,
		})

		--=========  mini.jump2d  =========--
		require("mini.jump2d").setup({
			silent = true,
			labels = "abcdefghijklmnopqrstuvwxyz",
			view = {
				dim = true,
				n_steps_ahead = 2,
			},
			mappings = {
				start_jumping = "F",
			},
		})
	end,
})
