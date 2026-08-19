local servers = {
	-- main three
	"clangd",
	"rust_analyzer",
	"gopls",
	-- config
	"pylsp",
	"lua_ls",
	"jsonls",
	"yamlls",
	"taplo",
	"marksman",
	-- front-end
	"ts_ls",
	"html",
	"cssls",
}

---------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local opts = { buffer = bufnr, silent = true }

		vim.keymap.set("n", "<leader>gh", function()
			vim.lsp.buf.hover({ focusable = true, focus = true })
			vim.defer_fn(function()
				vim.lsp.buf.hover({ border = "rounded" })
			end, 50)
		end, opts)
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
		-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>gb", "<C-o>", opts)
		-- refactor
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ef", vim.lsp.buf.code_action, opts)
		-- call and caller
		vim.keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, opts)
		vim.keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, opts)
		-- Inlay Hints
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
})

---------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>ek", function()
	vim.diagnostic.jump({ count = -1, float = false })
end, { silent = true })

vim.keymap.set("n", "<leader>ej", function()
	vim.diagnostic.jump({ count = 1, float = false })
end, { silent = true })

vim.keymap.set("n", "<leader>eh", vim.diagnostic.open_float, { silent = true })

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 2 },
	update_in_insert = false,
	severity_sort = true,
	-- underline = true,
	float = {
		border = "rounded",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

-- OPTIMIZATION: Defer Mason and LSP server activation using vim.schedule.
-- This prevents heavy Mason module loads and LSP server initializations from blocking
-- the synchronous initial UI frame render.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.pack.add({
				"https://github.com/williamboman/mason.nvim",
				"https://github.com/williamboman/mason-lspconfig.nvim",
				"https://github.com/neovim/nvim-lspconfig",
			})
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})
			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end
		end)
	end,
})
