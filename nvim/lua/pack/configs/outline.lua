-- === outline大纲 ===

local P = {
	name = "outline.nvim",
}

vim.keymap.set({ "n", "x" }, "<leader>e", function()
	PackUtils.load(P, function()
		require("outline").setup({
			outline_window = {
				position = "left",
				width = 20,
        --auto_close = true,
			},
			keymaps = {
				show_help = "?",
				close = { "<Esc>", "q" },
        -- jump to title
				peek_location = "o",
        -- jump to title and focus on content
				goto_location = "<Cr>",
        -- jump to title and focus on content and close outline
				goto_and_close = "<S-Cr>",

				-- Change cursor position of outline window to match current location in code.
				-- 'Opposite' of goto/peek_location.
				restore_location = "<C-g>",

				-- Open LSP/provider-dependent symbol hover information
				hover_symbol = "<C-space>",
				-- Preview location code of the symbol under cursor
				toggle_preview = "K",
				rename_symbol = "r",
				code_actions = "a",
				-- These fold actions are collapsing tree nodes, not code folding
				fold = "h",
				unfold = "l",
				fold_toggle = "<Tab>",
				fold_toggle_all = "<S-Tab>",
				fold_all = "N",
				unfold_all = "I",
				fold_reset = "R",
				-- Move down/up by one line and peek_location immediately.
				-- You can also use outline_window.auto_jump=true to do this for any
				-- j/k/<down>/<up>.
				up_and_jump = "<C-k>",
				down_and_jump = "<C-j>",
			},
		})
	end)
	vim.cmd("Outline")
end, { desc = "Toggle outline" })


-- vim.keymap.set("n", "<leader>l", "<cmd>OutlineFocus<cr>")
