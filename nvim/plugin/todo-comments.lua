vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })
			require("todo-comments").setup({
				signs = true,
				sign_priority = 8,

				keywords = {
					BUG = { icon = " ", color = "#DC2626" },
					TODO = { icon = " ", color = "#2563EB" },
					NOTE = { icon = "󱜾 ", color = "#10B981" },
				},
				merge_keywords = false,

				gui_style = {
					fg = "NONE",
					bg = "BOLD",
				},

				highlight = {
					multiline = true,
					multiline_pattern = "^.",
					multiline_context = 10,
					before = "",
					keyword = "fg",
					after = "",
					pattern = [[.*<(KEYWORDS)\s*:]],
					comments_only = true,
					max_line_len = 400,
					exclude = {},
				},

				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					pattern = [[\b(KEYWORDS):]],
				},
			})

			vim.keymap.set("n", "<C-M-j>", function()
				require("todo-comments").jump_next()
			end, { noremap = true, silent = true })

			vim.keymap.set("n", "<C-M-k>", function()
				require("todo-comments").jump_prev()
			end, { noremap = true, silent = true })
		end)
	end,
})
