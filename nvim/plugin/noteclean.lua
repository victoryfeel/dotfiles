vim.api.nvim_create_user_command("NoteClean", function()
	local root = vim.fn.expand("~/alexmak/notes")

	-- 前置检查：必须安装 ripgrep
	if vim.fn.executable("rg") == 0 then
		vim.notify(
			"❌ 极致性能版需要系统中安装有 ripgrep (rg) 命令，请先安装",
			vim.log.levels.ERROR
		)
		return
	end

	local search_dirs = {}
	if vim.fn.isdirectory(root .. "/core") == 1 then
		table.insert(search_dirs, root .. "/core")
	end
	if vim.fn.isdirectory(root .. "/assets/subpage") == 1 then
		table.insert(search_dirs, root .. "/assets/subpage")
	end

	if #search_dirs == 0 then
		vim.notify("❌ 在 " .. root .. " 下找不到 core 或 assets/subpage 目录", vim.log.levels.ERROR)
		return
	end

	local referenced_files = {}

	-- =========================================================
	-- 🔥 Ripgrep 极限扫描引擎 🔥
	-- 命令解释：无表头(--no-heading) 带文件名(--with-filename)
	-- 仅输出匹配部分(-o) 正则匹配所有的 ](xxxxx)
	-- =========================================================
	local cmd = {
		"rg",
		"--no-heading",
		"--with-filename",
		"-o",
		"\\]\\(([^\\)]+)\\)", -- 核心正则：匹配 ]( 后面的任意非 ) 字符
	}
	for _, dir in ipairs(search_dirs) do
		table.insert(cmd, dir)
	end

	-- 执行系统命令并将结果输出为 Lua 数组
	local lines = vim.fn.systemlist(cmd)

	-- ripgrep 输出格式极其标准，类似:
	-- /Users/alex/notes/core/note1.md:](../assets/image/pic.png)
	for _, line in ipairs(lines) do
		-- 利用 Lua 模式匹配瞬间切分出【绝对路径】和【链接内容】
		local filepath, link = line:match("^(.-):%]%((.+)%)$")
		if filepath and link then
			-- 剔除锚点(#)和空格
			local path_only = link:match("^([^%s#]+)")
			if path_only and not path_only:match("^http") then
				local current_md_dir = vim.fn.fnamemodify(filepath, ":p:h")
				-- 将相对链接还原为绝对路径并存入哈希表
				local abs_path = vim.fn.fnamemodify(current_md_dir .. "/" .. path_only, ":p")
				referenced_files[abs_path] = true
			end
		end
	end

	-- =========================================================
	-- 下面的逻辑维持原样：收集物理文件并比对差集
	-- 因为获取目录下的物理文件列表，Neovim 底层的 C API 已经是 O(1) 的最优解了
	-- =========================================================
	local all_assets = {}
	vim.list_extend(all_assets, vim.fn.globpath(root .. "/assets/image", "**/*", false, true))
	vim.list_extend(all_assets, vim.fn.globpath(root .. "/assets/subpage", "**/*.md", false, true))

	local unused_files = {}
	for _, file in ipairs(all_assets) do
		if vim.fn.filereadable(file) == 1 then
			if not referenced_files[vim.fn.fnamemodify(file, ":p")] then
				table.insert(unused_files, file)
			end
		end
	end

	if #unused_files == 0 then
		vim.notify("🎉 工作区很干净，没有未引用的资源需要清理。", vim.log.levels.INFO)
		return
	end

	-- 生成确认界面 (UI)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, "NoteClean_Confirm_UI")
	vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

	local display_lines = {
		"# 🗑️ [ Ripgrep 极速引擎 ] 扫描到 " .. #unused_files .. " 个未引用的资源文件",
		"# ----------------------------------------------------------------",
		"# 确认下方列表后，输入 :w 确认删除，或者按 q 退出。",
		"# ----------------------------------------------------------------",
	}
	for _, f in ipairs(unused_files) do
		table.insert(display_lines, f)
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, display_lines)

	vim.cmd("vsplit")
	vim.api.nvim_win_set_buf(0, buf)

	-- 挂载保存事件，执行删除
	vim.api.nvim_create_autocmd("BufWriteCmd", {
		buffer = buf,
		callback = function()
			local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			local count = 0
			for _, line in ipairs(buf_lines) do
				if line:match("^[^#]") and line:match("%S") then
					if vim.fn.delete(line) == 0 then
						count = count + 1
					end
				end
			end
			vim.cmd("bd!")
			vim.notify("✅ 成功清理了 " .. count .. " 个未引用的资源文件！", vim.log.levels.INFO)
		end,
	})

	vim.keymap.set("n", "q", ":bd!<CR>", { buffer = buf, silent = true, desc = "取消清理并退出" })
end, { desc = "Ripgrep 极致性能版清理孤儿资源" })
