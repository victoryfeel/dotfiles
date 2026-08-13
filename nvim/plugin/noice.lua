vim.schedule(function()
	vim.pack.add({
		"https://github.com/rcarriga/nvim-notify",
		"https://github.com/MunifTanjim/nui.nvim",
		"https://github.com/folke/noice.nvim",
	})

	require("notify").setup({
		background_colour = "#000000",
		minimum_width = 50,
		max_width = 50,
		-- render = "wrapped-compact",
		render = "compact",
	})

	require("noice").setup({
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true,
		},
		lsp = {
			progress = {
				enabled = false,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
			hover = {
				enabled = true,
			},
			-- disabled sign, config at blink.cmp
			signature = {
				enabled = false,
			},
		},
		notify = {
			enabled = true,
			view = "notify",
		},
		views = {
			history = {
				view = "popup",
				reverse = true,
			},
			cmdline_popup = {
				position = {
					row = "50%",
					col = "50%",
				},
				win_options = {
					winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
				},
			},
			cmdline_popupmenu = {
				relative = "editor",
				position = {
					row = "54%",
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
				},
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "emsg",
					find = "Error in decoration provider",
				},
				opts = { skip = true },
			},
		},
	})
end)

vim.keymap.set("n", "<leader>n", "<cmd>Noice history<CR>")
