local function ensure_dap(callback)
	if not package.loaded["dap"] then
		vim.schedule(function()
			vim.pack.add({
				"https://github.com/mfussenegger/nvim-dap",
				"https://github.com/nvim-neotest/nvim-nio",
				"https://github.com/rcarriga/nvim-dap-ui",
				"https://github.com/jay-babu/mason-nvim-dap.nvim",
				"https://github.com/leoluz/nvim-dap-go",
			})

			local dap = require("dap")
			local dapui = require("dapui")

			-- 1. 初始化 DAP UI 界面
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.35 },
							{ id = "breakpoints", size = 0.15 },
							{ id = "stacks", size = 0.35 },
							{ id = "watches", size = 0.15 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "rounded",
					mappings = { close = { "q", "<Esc>" } },
				},
			})

			-- 2. 自动生命周期响应：启动调试时自动打开 UI，结束/退出时自动收起 UI
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- 3. Mason DAP 注册适配器处理句柄 (自动关联 Mason 安装的 codelldb 和 delve)
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "delve" },
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			-- 4. 初始化 Go 专用调试配置
			require("dap-go").setup()

			-- 5. 显式注册 codelldb 适配器兜底（确保系统 PATH 或 Mason 中的 codelldb 被正确绑定）
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
			}

			-- AI Edit: 方案二：智能自动查找编译产物，优先自动匹配，找不到时才弹窗询问
			local get_executable_path = function()
				local cwd = vim.fn.getcwd()
				local fname = vim.fn.expand("%:t:r")

				-- 检查常见的编译产物路径
				local candidate_paths = {
					cwd .. "/build/" .. fname,
					cwd .. "/" .. fname,
					cwd .. "/a.out",
					cwd .. "/target/debug/" .. fname,
				}

				for _, path in ipairs(candidate_paths) do
					if vim.fn.executable(path) == 1 then
						return path
					end
				end

				-- 自动推导未找到时，回退到交互式输入框
				return vim.fn.input("Executable path: ", cwd .. "/", "file")
			end

			-- 配置 C / C++ / Rust 调试属性
			dap.configurations.cpp = {
				{
					name = "Launch C/C++ Executable",
					type = "codelldb",
					request = "launch",
					program = get_executable_path,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			-- 自定义断点高亮与符号外观
			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint", { text = "🟢", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "▶️", texthl = "DiagnosticWarn", linehl = "CursorLine", numhl = "CursorLine" }
			)

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
vim.keymap.set("n", "<leader>db", function()
	ensure_dap(function()
		require("dap").toggle_breakpoint()
	end)
end, { silent = true })

vim.keymap.set("n", "<F5>", function()
	ensure_dap(function()
		require("dap").continue()
	end)
end, { silent = true })

vim.keymap.set("n", "<F10>", function()
	ensure_dap(function()
		require("dap").step_over()
	end)
end, { silent = true })

vim.keymap.set("n", "<F11>", function()
	ensure_dap(function()
		require("dap").step_into()
	end)
end, { silent = true })

vim.keymap.set("n", "<F12>", function()
	ensure_dap(function()
		require("dap").step_out()
	end)
end, { silent = true })

vim.keymap.set("n", "<leader>du", function()
	ensure_dap(function()
		require("dapui").toggle()
	end)
end, { silent = true })
