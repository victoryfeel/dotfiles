vim.keymap.set("n", "<leader>ee", function()
	if not package.loaded["outline"] then
		vim.pack.add({ "https://github.com/hedyhli/outline.nvim" })
		require("outline").setup({
			outline_window = {
				position = "left",
				width = 20,
				--auto_close = true,
			},
			keymaps = {
				close = { "<Esc>" },
				peek_location = "o",
				rename_symbol = "r",
				fold = "h",
				unfold = "l",
				fold_toggle_all = "<Tab>",
				up_and_jump = "<C-k>",
				down_and_jump = "<C-j>",
			},
		})
	end
	vim.cmd("Outline")
end, { desc = "Toggle Outline" })
