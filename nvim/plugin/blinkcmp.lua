vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/rafamadriz/friendly-snippets",
			"https://github.com/saghen/blink.cmp",
		})
		require("blink.cmp").setup({
			fuzzy = {
				prebuilt_binaries = {
					force_version = "v*",
				},
			},
			cmdline = {
				completion = {
					list = { selection = { preselect = false, auto_insert = true } },
					menu = {
						auto_show = function()
							return vim.fn.getcmdtype() == ":"
						end,
					},
					ghost_text = { enabled = false },
				},
			},
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-e>"] = { "snippet_forward", "select_next", "fallback" },
				["<C-u>"] = { "snippet_backward", "select_prev", "fallback" },
			},
			completion = {
				keyword = { range = "full" },
				documentation = { auto_show = true, auto_show_delay_ms = 0 },
				list = { selection = { preselect = false, auto_insert = false } },
				menu = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				},
			},
			signature = { enabled = true },
			enabled = function()
				return not vim.tbl_contains({}, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "buffer", "lsp", "path", "snippets" },
				providers = {
					buffer = { score_offset = 5 },
					path = { score_offset = 3 },
					lsp = { score_offset = 2 },
					snippets = { score_offset = 1 },
				},
			},
		})
	end,
})
