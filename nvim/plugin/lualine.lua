vim.schedule(function()
	vim.pack.add({
		"https://github.com/nvim-tree/nvim-web-devicons",
		"https://github.com/nvim-lualine/lualine.nvim",
	})

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "\u{e0b1}", right = "\u{e0b1}" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
				refresh_time = 16, -- ~60fps
				events = {
					"WinEnter",
					"BufEnter",
					"BufWritePost",
					"SessionLoadPost",
					"FileChangedShellPost",
					"VimResized",
					"Filetype",
					"CursorMoved",
					"CursorMovedI",
					"ModeChanged",
				},
			},
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{ "branch", icon = "\u{e725}" },
				{ "filename", path = 0 },
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
			--lualine_z = { "progress" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{ "filename", path = 0 },
				{ "filetype", colored = false },
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
			--lualine_z = { "progress" },
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end)
