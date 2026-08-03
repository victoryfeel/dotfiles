vim.schedule(function()
	if not package.loaded["render-markdown"] then
		vim.pack.add({
			--"https://github.com/hakonharnes/img-clip.nvim",
			"https://github.com/nvim-treesitter/nvim-treesitter",
			"https://github.com/nvim-tree/nvim-web-devicons",
			"https://github.com/MeanderingProgrammer/render-markdown.nvim",
		})

		vim.api.nvim_set_hl(0, "Headline1Bg", { fg = "#000000", bg = "#5b4b9c" })
		vim.api.nvim_set_hl(0, "Headline2Bg", { fg = "#000000", bg = "#229c6a" })
		vim.api.nvim_set_hl(0, "Headline3Bg", { fg = "#000000", bg = "#0081a1" })

		vim.api.nvim_set_hl(0, "Headline1Fg", { fg = "#000000", bold = true })
		vim.api.nvim_set_hl(0, "Headline2Fg", { fg = "#000000", bold = true })
		vim.api.nvim_set_hl(0, "Headline3Fg", { fg = "#000000", bold = true })

		require("render-markdown").setup({
			enabled = true,
			render_modes = { "n", "c", "t" },
			heading = {
				sign = false,
				icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
				position = "inline",
				backgrounds = {
					"Headline1Bg",
					"Headline2Bg",
					"Headline3Bg",
				},
				foregrounds = {
					"Headline1Fg",
					"Headline2Fg",
					"Headline3Fg",
				},
			},
			code = {
				enabled = true,
				sign = false,
				style = "full",
				border = "thin",
			},
			bullet = {
				enabled = true,
				--icons = { "• ", "◦ ", "◆ ", "◇ " },
			},
			checkbox = {
				enabled = true,
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
			html = {
				enabled = true,
				comment = {
					conceal = false,
				},
			},
			link = {
				image = vim.g.neovim_mode == "skitty" and "" or "󰥶 ",
				custom = {
					youtu = { pattern = "youtu%.be", icon = "󰗃 " },
				},
			},
			table = {
				enabled = true,
				border = "thin",
			},
			anti_conceal = {
				enabled = true,
			},
			completions = {
				lsp = { enabled = true },
			},
		})
	end
end)
