local cached_branch = ""
local last_check = 0

local function git_branch()
	local now = vim.loop.now()
	if now - last_check > 5000 then
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
		last_check = now
	end
	return cached_branch ~= "" and (" \u{e725} " .. cached_branch .. " ") or ""
end

_G.git_branch = git_branch

local augroup = vim.api.nvim_create_augroup("CustomStatusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = augroup,
	callback = function()
		-- don't show statusline on float window
		local win_config = vim.api.nvim_win_get_config(0)
		if win_config.relative ~= "" or vim.bo.buftype == "terminal" or vim.bo.buftype == "nofile" then
			vim.opt_local.statusline = ""
			return
		end

		vim.opt_local.statusline = table.concat({
			" ",
			"%{v:lua.git_branch()}",
			"\u{e0b1} %F %h%m%r",
			"%=",
			" \u{f017} %l:%c ",
		})
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = augroup,
	callback = function()
		vim.opt_local.statusline = table.concat({
			" %#StatusLine#",
			"%{v:lua.git_branch()}",
			"\u{e0b1} %t %h%m%r ",
		})
	end,
})
