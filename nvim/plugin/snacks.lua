vim.pack.add({ "https://github.com/folke/snacks.nvim" })

-- rainbow-indent
vim.opt.list = true
vim.opt.listchars = {
	lead = "·",
	trail = "·",
	nbsp = "␣",
	tab = "→ ",
}
vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#5e5738" })
vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#3c5f4e" })
vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#5e4568" })
vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#375768" })
-- lazygit
vim.api.nvim_set_hl(0, "LazyGitActiveBorder", { fg = "#50fa7b", bold = true })

require("snacks").setup({
	--=========  snacks.image  =========--
	image = {
		enabled = false,
		doc = {
			inline = false,
			float = true,
			max_width = 50,
			max_height = 30,
		},
	},
	--=========  snacks.lazygit  =========--
	lazygit = {
		theme = {
			activeBorderColor = { fg = "LazyGitActiveBorder", bold = true },
		},
	},
	--=========  snacks.indent  =========--
	indent = {
		indent = {
			char = "│",
			hl = {
				"SnacksIndent1",
				"SnacksIndent2",
				"SnacksIndent3",
				"SnacksIndent4",
			},
		},
		scope = {
			enabled = false,
		},
		animate = {
			enabled = false,
		},
	},
	--=========  snacks parts config  =========--
	styles = {
		lazygit = {
			border = "rounded",
			width = 0.9,
			height = 0.9,
			wo = {
				winblend = 0,
			},
		},
		snacks_image = {
			border = "rounded",
			backdrop = false,
			--relative = "editor",
			--col = -1,
		},
	},
})

--=========  keymap  =========--
local Snacks = require("snacks")
vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end)
