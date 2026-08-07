vim.schedule(function()
	if not package.loaded["render-markdown"] then
		vim.pack.add({
			"https://github.com/hakonharnes/img-clip.nvim",
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

		-- ==================== render-markdown ======================= --
		require("render-markdown").setup({
			enabled = true,
			render_modes = { "n", "c", "t" },
			heading = {
				sign = false,
				icons = { "  󰎤  ", "  󰎧  ", "  󰎪  ", "  󰎭  ", "  󰎱  ", "  󰎳  " },
				position = "inline",
				border = true,
				render_modes = true,
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
				-- general
				width = "block",
				min_width = 80,
				sign = false,
				-- borders
				border = "thin",
				left_pad = 1,
				right_pad = 1,
				-- language info
				position = "right",
				language_icon = true,
				language_name = true,
				-- avoid making headings ugly
				highlight_inline = "RenderMarkdownCodeInfo",
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
				image = " ",
				hyperlink = "󰧮 ",
				custom = {
					web = { icon = " ", pattern = "^http" },
					youtube = { icon = " ", pattern = "youtube[^.]*%.com", kind = "url" },
				},
			},
			pipe_table = {
				alignment_indicator = "─",
				border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
				head = "Normal",
				row = "Normal",
				preset = "round",
				cell = "trimmed",
				padding = 1,
				min_width = 10,
			},
			anti_conceal = {
				enabled = true,
				--disabled_modes = { "n" },
				ignore = {
					head_border = true,
					head_background = true,
				},
			},
			completions = {
				blink = { enabled = true },
				lsp = { enabled = true },
			},
		})

		-- ==================== img-clip ======================= --
		require("img-clip").setup({
			default = {
				dir_path = function()
					local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
					if vim.v.shell_error == 0 then
						return git_root .. "/assets/image"
					end
					return "/assets/image"
				end,
				use_absolute_path = false,
				copy_images = true,
				prompt_for_file_name = false,
				file_name = "%y%m%d-%H%M%S",
				extension = "jpg",
				process_cmd = "magick convert - -quality 100 -sampling-factor 4:4:4 jpg:-",
				formats = { "jpg" },
			},
			filetypes = {
				markdown = {
					template = "![image$CURSOR]($FILE_PATH)",
				},
			},
		})
	end
end)

vim.keymap.set("n", "<leader>pi", "<cmd>PasteImage<cr>", { buffer = true, silent = true })
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
