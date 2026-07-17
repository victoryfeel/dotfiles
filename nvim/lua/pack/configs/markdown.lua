-- === Markdown 渲染美化 (render-markdown.nvim) ===
if vim.g.vscode then return end

local P = {
	name = "render-markdown.nvim",
	deps = { "nvim-treesitter", "nvim-tree/nvim-web-devicons" },
}

-- 仅在打开 markdown 文件时触发懒加载
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	once = true,
	callback = function()
		PackUtils.load(P, function()
			require("render-markdown").setup({
				enabled = true,
				render_modes = { "n", "c", "t" },

				heading = {
					enabled = true,
					sign = false,
					icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
				},

				code = {
					enabled = true,
					sign = false,
					style = "full",
					border = "thin",
				},

				bullet = {
					enabled = true,
					icons = { "• ", "◦ ", "◆ ", "◇ " },
				},

				checkbox = {
					enabled = true,
					unchecked = { icon = "󰄱 " },
					checked = { icon = "󰱒 " },
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
		end)
	end,
})
