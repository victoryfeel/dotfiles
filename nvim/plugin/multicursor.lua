vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.pack.add({ "https://github.com/jake-stewart/multicursor.nvim" })

			local mc = require("multicursor-nvim")
			mc.setup()

			local set = vim.keymap.set

			set({ "n", "v" }, "<C-n>", function()
				mc.matchAddCursor(1)
			end)
			set({ "n", "v" }, "<C-p>", function()
				mc.matchAddCursor(-1)
			end)

			set({ "n", "v" }, "<leader><C-n>", function()
				mc.matchSkipCursor(1)
			end)
			set({ "n", "v" }, "<leader><C-p>", function()
				mc.matchSkipCursor(-1)
			end)

			set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

			set("n", "<esc>", function()
				if package.loaded["multicursor-nvim"] and require("multicursor-nvim").hasCursors() then
					require("multicursor-nvim").clearCursors()
				else
					vim.cmd("nohlsearch")
					vim.cmd("Noice dismiss")
				end
			end)
		end)
	end,
})
