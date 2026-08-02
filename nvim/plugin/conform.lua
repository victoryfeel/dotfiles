vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/williamboman/mason.nvim",
			"https://github.com/mason-org/mason-registry",
			"https://github.com/stevearc/conform.nvim",
		})
		require("mason").setup()

		local ensure_installed = {
			-- main three
			"clang-format",
			"rustfmt",
			"goimports",
			"gofumpt",
			-- tool
			"stylua",
			"isort",
			"black",
			"shfmt",
			-- front-end
			"prettier",
		}
		---------------------------------------------------------------------------------
		local registry = require("mason-registry")
		registry.refresh(function()
			for _, tool_name in ipairs(ensure_installed) do
				if registry.has_package(tool_name) then
					local pkg = registry.get_package(tool_name)
					if not pkg:is_installed() then
						pkg:install()
						vim.notify("Mason installing formatter: " .. tool_name, vim.log.levels.INFO)
					end
				end
			end
		end)
		---------------------------------------------------------------------------------
		require("conform").setup({
			formatters_by_ft = {
				-- main three
				c = { "clang-format", lsp_format = "fallback" },
				cpp = { "clang-format", lsp_format = "fallback" },
				rust = { "rustfmt", lsp_format = "fallback" },
				go = { "goimports", "gofumpt", lsp_format = "fallback" },
				-- tools
				python = { "isort", "black" },
				lua = { "stylua" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				-- front-end
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--config-precedence", "prefer-file" },
				},
			},
		})
	end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({
			bufnr = args.buf,
			async = false,
			lsp_fallback = true,
		})
	end,
})
