local function ensure_overseer(callback)
	if not package.loaded["overseer"] then
		vim.schedule(function()
			vim.pack.add({
				"https://github.com/stevearc/overseer.nvim",
			})

			local overseer = require("overseer")
			overseer.setup({
				strategy = "terminal",
				templates = { "builtin" },
				task_list = {
					direction = "bottom",
					min_height = 8,
					max_height = 12,
					default_detail = 1,
					bindings = {
						["?"] = "ShowHelp",
						["g?"] = "ShowHelp",
						["<CR>"] = "RunAction",
						["<C-e>"] = "Edit",
						["o"] = "Open",
						["<C-v>"] = "OpenVsplit",
						["<C-s>"] = "OpenSplit",
						["<C-f>"] = "OpenFloat",
						["p"] = "TogglePreview",
						["<C-l>"] = "IncreaseDetail",
						["<C-h>"] = "DecreaseDetail",
						["L"] = "IncreaseAllDetail",
						["H"] = "DecreaseAllDetail",
						["["] = "DecreaseWidth",
						["]"] = "IncreaseWidth",
						["{"] = "PrevTask",
						["}"] = "NextTask",
						["r"] = "Restart",
						["q"] = "Close",
					},
				},
				component_aliases = {
					default = {
						{ "display_duration", detail = true },
						"on_exit_set_status",
						"on_complete_notify",
						{ "on_output_quickfix", open = false },
					},
				},
			})

			if callback then
				callback()
			end
		end)
	else
		if callback then
			callback()
		end
	end
end

-- === 快捷键绑定 ===
vim.keymap.set("n", "<leader>or", function()
	ensure_overseer(function()
		vim.cmd("OverseerRun")
	end)
end, { silent = true, desc = "运行项目构建任务 (OverseerRun)" })

vim.keymap.set("n", "<leader>ow", function()
	ensure_overseer(function()
		vim.cmd("OverseerToggle")
	end)
end, { silent = true, desc = "打开/关闭构建任务控制台 (OverseerToggle)" })

vim.keymap.set("n", "<leader>oq", function()
	ensure_overseer(function()
		vim.cmd("OverseerQuickAction")
	end)
end, { silent = true, desc = "对最新任务执行快捷操作 (OverseerQuickAction)" })
