vim.schedule(function()
	if not package.loaded["render-markdown"] then
		vim.pack.add({
			"https://github.com/nvim-treesitter/nvim-treesitter",
			"https://github.com/nvim-tree/nvim-web-devicons",
			"https://github.com/MeanderingProgrammer/render-markdown.nvim",
		})

		vim.api.nvim_set_hl(0, "Headline1Bg", { fg = "#000000", bg = "#5b4b9c" })
		vim.api.nvim_set_hl(0, "Headline2Bg", { fg = "#000000", bg = "#229c6a" })
		vim.api.nvim_set_hl(0, "Headline3Bg", { fg = "#000000", bg = "#0081a1" })

		vim.api.nvim_set_hl(0, "Headline1Fg", { fg = "#000000", bold = true })
		vim.api.nvim_set_hl(0, "Headline2Fg", { fg = "#000000", bold = true })
		vim.api.nvim_set_hl(0, "Headline3Fg", { fg = "#000000", bold = true })

		-- ==================== render-markdown ======================= --
		require("render-markdown").setup({
			enabled = true,
			render_modes = { "n", "c", "t" },
			heading = {
				sign = false,
				icons = { "  󰎤  ", "  󰎧  ", "  󰎪  ", "  󰎭  ", "  󰎱  ", "  󰎳  " },
				position = "inline",
				border = true,
				render_modes = true,
				backgrounds = {
					"Headline1Bg",
					"Headline2Bg",
					"Headline3Bg",
				},
				foregrounds = {
					"Headline1Fg",
					"Headline2Fg",
					"Headline3Fg",
				},
			},
			code = {
				-- general
				width = "block",
				min_width = 80,
				sign = false,
				-- borders
				border = "thin",
				left_pad = 1,
				right_pad = 1,
				-- language info
				position = "right",
				language_icon = true,
				language_name = true,
				-- avoid making headings ugly
				highlight_inline = "RenderMarkdownCodeInfo",
			},
			checkbox = {
				enabled = true,
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
			html = {
				enabled = true,
				comment = {
					conceal = false,
				},
			},
			link = {
				image = " ",
				hyperlink = "󰧮 ",
				custom = {
					web = { icon = " ", pattern = "^http" },
					youtube = { icon = " ", pattern = "youtube[^.]*%.com", kind = "url" },
				},
			},
			pipe_table = {
				alignment_indicator = "─",
				border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
				head = "Normal",
				row = "Normal",
				preset = "round",
				cell = "trimmed",
				padding = 1,
				min_width = 10,
			},
			anti_conceal = {
				enabled = true,
				--disabled_modes = { "n" },
				ignore = {
					head_border = true,
					head_background = true,
				},
			},
			completions = {
				blink = { enabled = true },
				lsp = { enabled = true },
			},
		})
	end
end)

-- OPTIMIZATION: Lazy-load img-clip.nvim only on keypress (<leader>pi)
-- to avoid loading clipboard image pasting plugin on initial markdown buffer open.
vim.keymap.set("n", "<leader>pi", function()
	if not package.loaded["img-clip"] then
		vim.pack.add({ "https://github.com/hakonharnes/img-clip.nvim" })
		require("img-clip").setup({
			default = {
				dir_path = function()
					local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
					if vim.v.shell_error == 0 then
						return git_root .. "/assets/image"
					end
					return "/assets/image"
				end,
				use_absolute_path = false,
				copy_images = true,
				prompt_for_file_name = false,
				file_name = "%y%m%d-%H%M%S",
				extension = "jpg",
				process_cmd = "magick convert - -quality 100 -sampling-factor 4:4:4 jpg:-",
				formats = { "jpg" },
			},
			filetypes = {
				markdown = {
					template = "![image$CURSOR]($FILE_PATH)",
				},
			},
		})
	end
	vim.cmd("PasteImage")
end, { buffer = true, silent = true })

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- snippets
local function map(lhs, rhs)
	vim.keymap.set("i", lhs, rhs, { buffer = true })
end

map(",s", "~~~~ <++><Esc>F~hi")
map(",i", "** <++><Esc>F*i")
map(",d", "`` <++><Esc>F`i")
map(",b", "**** <++><Esc>F*hi")
map(",a", "[](<++>) <++><Esc>F[a")
map(",p", "![](<++>) <++><Esc>F[a")
map(",1", "# <CR><++><Esc>kA")
map(",2", "## <CR><++><Esc>kA")
map(",3", "### <CR><++><Esc>kA")
map(",c", "```<CR><++><CR>```<CR><CR><++><Esc>4kA")
map(",m", "- [ ] ")
map(",n", "---<CR><CR>")
map(",l", "--------<CR>")

-- =========================================================
-- NoteClean: Clean orphaned note assets
-- =========================================================
vim.api.nvim_buf_create_user_command(0, "NoteClean", function()
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

	local unused_items = {}
	for _, file in ipairs(all_assets) do
		if vim.fn.filereadable(file) == 1 then
			local abs = vim.fn.fnamemodify(file, ":p")
			if not referenced_files[abs] then
				local rel = abs:gsub("^" .. vim.pesc(root .. "/"), "")
				table.insert(unused_items, {
					abs_path = abs,
					rel_path = rel,
					marked = true,
				})
			end
		end
	end

	if #unused_items == 0 then
		vim.notify("Workspace is clean. No unreferenced assets found.", vim.log.levels.INFO)
		return
	end

	-- =========================================================
	-- Floating Dual-Pane UI: Left (List) | Right (Preview)
	-- =========================================================
	local total_width = math.floor(vim.o.columns * 0.85)
	local total_height = math.floor(vim.o.lines * 0.8)
	local start_row = math.floor((vim.o.lines - total_height) / 2)
	local start_col = math.floor((vim.o.columns - total_width) / 2)

	local left_width = math.floor(total_width * 0.45)
	local right_width = total_width - left_width - 2

	-- Left buffer & window
	local left_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = left_buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = left_buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = left_buf })

	local left_win = vim.api.nvim_open_win(left_buf, true, {
		relative = "editor",
		width = left_width,
		height = total_height,
		row = start_row,
		col = start_col,
		border = "rounded",
		title = " Unreferenced Assets (<Space>: Toggle, D: Delete, <Esc>: Abort) ",
		title_pos = "center",
	})

	-- Right buffer & window
	local right_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = right_buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = right_buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = right_buf })

	local right_win = vim.api.nvim_open_win(right_buf, false, {
		relative = "editor",
		width = right_width,
		height = total_height,
		row = start_row,
		col = start_col + left_width + 2,
		border = "rounded",
		title = " Preview ",
		title_pos = "center",
	})

	local function render_list()
		local lines_to_set = {}
		for _, item in ipairs(unused_items) do
			local mark = item.marked and "[x] " or "[ ] "
			table.insert(lines_to_set, mark .. item.rel_path)
		end
		vim.api.nvim_set_option_value("modifiable", true, { buf = left_buf })
		vim.api.nvim_buf_set_lines(left_buf, 0, -1, false, lines_to_set)
		vim.api.nvim_set_option_value("modifiable", false, { buf = left_buf })
	end

	local function update_preview()
		if not vim.api.nvim_win_is_valid(left_win) or not vim.api.nvim_win_is_valid(right_win) then
			return
		end
		local cursor = vim.api.nvim_win_get_cursor(left_win)
		local idx = cursor[1]
		local item = unused_items[idx]
		if not item then
			return
		end

		local preview_lines = {}
		local ext = vim.fn.fnamemodify(item.abs_path, ":e"):lower()

		if ext == "md" or ext == "txt" or ext == "html" or ext == "json" or ext == "lua" then
			preview_lines = vim.fn.readfile(item.abs_path)
			vim.api.nvim_set_option_value("filetype", ext == "md" and "markdown" or ext, { buf = right_buf })
		else
			local size_bytes = vim.fn.getfsize(item.abs_path)
			local size_str = size_bytes >= 1048576 and string.format("%.2f MB", size_bytes / 1048576)
				or string.format("%.2f KB", size_bytes / 1024)

			table.insert(preview_lines, "File: " .. item.rel_path)
			table.insert(preview_lines, "Path: " .. item.abs_path)
			table.insert(preview_lines, "Size: " .. size_str)
			table.insert(preview_lines, "Type: " .. (ext == "" and "Unknown" or ext:upper() .. " file"))
			table.insert(preview_lines, "")
			table.insert(preview_lines, "[ Binary / Image File - Raw content not previewed ]")
			vim.api.nvim_set_option_value("filetype", "", { buf = right_buf })
		end

		vim.api.nvim_win_set_config(right_win, {
			title = " Preview: " .. vim.fn.fnamemodify(item.rel_path, ":t") .. " ",
			title_pos = "center",
		})

		vim.api.nvim_set_option_value("modifiable", true, { buf = right_buf })
		vim.api.nvim_buf_set_lines(right_buf, 0, -1, false, preview_lines)
		vim.api.nvim_set_option_value("modifiable", false, { buf = right_buf })
	end

	local function close_all()
		if vim.api.nvim_win_is_valid(left_win) then
			vim.api.nvim_win_close(left_win, true)
		end
		if vim.api.nvim_win_is_valid(right_win) then
			vim.api.nvim_win_close(right_win, true)
		end
	end

	render_list()
	update_preview()

	local augroup = vim.api.nvim_create_augroup("NoteCleanPreview_" .. left_buf, { clear = true })
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = augroup,
		buffer = left_buf,
		callback = update_preview,
	})

	vim.api.nvim_create_autocmd("WinClosed", {
		group = augroup,
		pattern = tostring(left_win),
		callback = function()
			if vim.api.nvim_win_is_valid(right_win) then
				vim.api.nvim_win_close(right_win, true)
			end
		end,
	})

	-- Keymap: <Space> to toggle mark
	vim.keymap.set("n", "<Space>", function()
		local cursor = vim.api.nvim_win_get_cursor(left_win)
		local idx = cursor[1]
		if unused_items[idx] then
			unused_items[idx].marked = not unused_items[idx].marked
			render_list()
			if idx < #unused_items then
				vim.api.nvim_win_set_cursor(left_win, { idx + 1, 0 })
			else
				vim.api.nvim_win_set_cursor(left_win, { idx, 0 })
			end
			update_preview()
		end
	end, { buffer = left_buf, silent = true, desc = "Toggle file mark for deletion" })

	-- Keymap: 'a' to toggle all marks
	vim.keymap.set("n", "a", function()
		local all_marked = true
		for _, item in ipairs(unused_items) do
			if not item.marked then
				all_marked = false
				break
			end
		end
		for _, item in ipairs(unused_items) do
			item.marked = not all_marked
		end
		render_list()
	end, { buffer = left_buf, silent = true, desc = "Toggle all files mark" })

	-- Keymap: 'D' / '<CR>' to trigger deletion with "yes" confirmation
	local function trigger_delete()
		local marked_count = 0
		for _, item in ipairs(unused_items) do
			if item.marked then
				marked_count = marked_count + 1
			end
		end

		if marked_count == 0 then
			vim.notify("No files selected for deletion.", vim.log.levels.WARN)
			return
		end

		vim.ui.input({
			prompt = string.format("Delete %d marked file(s)? Type 'yes' to confirm: ", marked_count),
		}, function(input)
			if input ~= "yes" then
				vim.notify("Deletion cancelled.", vim.log.levels.WARN)
				return
			end

			local count = 0
			for _, item in ipairs(unused_items) do
				if item.marked then
					if vim.fn.delete(item.abs_path) == 0 then
						count = count + 1
					end
				end
			end

			close_all()
			vim.notify(string.format("Successfully removed %d unreferenced asset file(s).", count), vim.log.levels.INFO)
		end)
	end

	vim.keymap.set("n", "D", trigger_delete, { buffer = left_buf, silent = true, desc = "Delete marked files" })

	-- Keymap: 'q' / '<Esc>' to abort
	vim.keymap.set("n", "q", close_all, { buffer = left_buf, silent = true, desc = "Cancel and close" })
	vim.keymap.set("n", "<Esc>", close_all, { buffer = left_buf, silent = true, desc = "Cancel and close" })
end, { desc = "Clean orphaned note assets using ripgrep" })
