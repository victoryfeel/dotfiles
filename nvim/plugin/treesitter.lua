vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("NativeTreesitterSetup", { clear = true }),
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype
		-- filter blankfile, invalid terminal, yazi, and non-code file
		if ft == "" or ft == "yazi" or vim.bo[buf].buftype ~= "" then
			return
		end
		-- filter larfile > 100KB
		local max_filesize = 100 * 1024
		local filepath = vim.api.nvim_buf_get_name(buf)
		local ok, stats = pcall(vim.uv.fs_stat, filepath)
		if ok and stats and stats.size > max_filesize then
			return
		end

		local lang = vim.treesitter.language.get_lang(ft) or ft
		pcall(vim.treesitter.start, buf, lang)
	end,
})
