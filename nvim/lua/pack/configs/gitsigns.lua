-- === git signs ===

local P = {
	name = "gitsigns.nvim",
}

-- 懒加载触发器
vim.api.nvim_create_autocmd({
	"UIEnter", -- vim.schedule(function()
}, {
	once = true,
	callback = function()
		vim.schedule(function()
			PackUtils.load(P, function()
				require('gitsigns').setup {
					on_attach = function()
						local gitsigns = require('gitsigns')
						local map = require("core.keymap")
						-- Navigation
						map:lua('t=', function()
							gitsigns.nav_hunk('next')
						end)
						map:lua('t-', function()
							gitsigns.nav_hunk('prev')
						end)
						-- show diff
						map:lua('<leader>hd', gitsigns.diffthis)
					end
				}
			end)
		end)
	end
})



-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
-- 	once = true, -- 确保只触发一次
-- 	callback = function()
-- 		vim.pack.add({ "https://www.github.com/lewis6991/gitsigns.nvim" })
-- 
-- 		require("gitsigns").setup({
-- 			signs = {
-- 				add = { text = "▏" },
-- 				change = { text = "▐" },
-- 				delete = { text = "◦" },
-- 				topdelete = { text = "◦" },
-- 				changedelete = { text = "●" },
-- 				untracked = { text = "○" },
-- 			},
-- 			signcolumn = true,
-- 			current_line_blame = false,
-- 		})
-- 	end,
-- })
