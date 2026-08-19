vim.api.nvim_create_user_command("NoteClean", function()
	local root = vim.fn.expand("~/alexmak/notes")

	local referenced_files = {}

	-- =========================================================
	-- Ripgrep to search attachments
	-- =========================================================
	local cmd = {
		"rg",
		"--no-heading",
		"--with-filename",
		"-e",
		"\\]\\(",
		root .. "/core",
		root .. "/assets/subpage",
	}

	-- Execute system command and return output as Lua array
	local lines = vim.fn.systemlist(cmd)

	-- Helper: parse link target and normalize to absolute path in reference table
	local function record_reference(raw_path, current_md_dir)
		if not raw_path or raw_path == "" or raw_path:match("^https?://") or raw_path:match("^mailto:") then
			return
		end

		-- 1. URL decode (handle %20 space and hex encoded characters)
		raw_path = raw_path:gsub("%%(%x%x)", function(h)
			return string.char(tonumber(h, 16))
		end)

		-- 2. Strip optional Markdown title "title" / 'title'
		raw_path = raw_path:match("^([^\"']-)%s+[\"'].*[\"']$") or raw_path

		-- 3. Strip anchor #anchor and surrounding whitespace
		raw_path = raw_path:match("^([^#]+)") or raw_path
		raw_path = raw_path:match("^%s*(.-)%s*$") or raw_path
		if raw_path == "" then
			return
		end

		-- 4. Resolve and record absolute paths (relative to current file and note root)
		referenced_files[vim.fn.fnamemodify(current_md_dir .. "/" .. raw_path, ":p")] = true
		referenced_files[vim.fn.fnamemodify(root .. "/" .. raw_path, ":p")] = true
	end

	for _, line in ipairs(lines) do
		-- Split file path and line content
		local filepath, content = line:match("^(/.-):(.*)$")
		if filepath and content then
			local current_md_dir = vim.fn.fnamemodify(filepath, ":p:h")

			-- Extract standard Markdown links ](...) using Lua balanced parentheses %b()
			for raw_paren in content:gmatch("%](%b())") do
				record_reference(raw_paren:sub(2, -2), current_md_dir)
			end
		end
	end

	-- =========================================================
	-- Collect physical asset files and compute difference set
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
		vim.notify("Workspace is clean. No unreferenced assets found.", vim.log.levels.INFO)
		return
	end

	-- Create confirmation buffer (UI)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, "NoteClean_Confirm_UI")
	vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

	local display_lines = {
		"# Found " .. #unused_files .. " unreferenced asset file(s)",
		"# ----------------------------------------------------------------",
		"# Review the list below. Write (:w) to delete, or press 'q' to abort.",
		"# ----------------------------------------------------------------",
	}
	for _, f in ipairs(unused_files) do
		table.insert(display_lines, f)
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, display_lines)

	vim.cmd("vsplit")
	vim.api.nvim_win_set_buf(0, buf)

	-- Attach save event to perform deletion
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
			vim.notify("Successfully removed " .. count .. " unreferenced asset file(s).", vim.log.levels.INFO)
		end,
	})

	vim.keymap.set("n", "q", ":bd!<CR>", { buffer = buf, silent = true, desc = "Cancel note clean and exit" })
end, { desc = "Clean orphaned note assets using ripgrep" })
