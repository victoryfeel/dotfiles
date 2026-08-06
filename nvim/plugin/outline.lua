vim.keymap.set("n", "<leader>ee", function()
	if not package.loaded["outline"] then
		vim.pack.add({ "https://github.com/hedyhli/outline.nvim" })
		require("outline").setup({
			outline_window = {
				position = "left",
				width = 20,
				--auto_close = true,
			},
			outline_items = {
				show_symbol_details = false,
			},
			keymaps = {
				close = { "<Esc>" },
				goto_location = "<Cr>",
				goto_and_close = "<S-Cr>",
				peek_location = "o",
				rename_symbol = "r",
				fold_toggle_all = "<Tab>",
				fold = "h",
				unfold = "l",
			},
		})
	end
	vim.cmd("Outline")
end, { desc = "Toggle Outline" })

vim.keymap.set("n", "<leader>h", function()
	if package.loaded["outline"] then
		vim.cmd("OutlineFocusOutline")
	end
end)

vim.keymap.set("n", "<leader>l", function()
	if package.loaded["outline"] then
		vim.cmd("OutlineFocusCode")
	end
end)
