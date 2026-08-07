local function ensure_fzf_lua()
	if not package.loaded["fzf-lua"] then
		vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
		require("fzf-lua").setup({
			previewers = {
				builtin = {
					-- ==== disabled image preview
					-- ueberzug_scaler = "fit_contain",
					-- chafa_opts = {
					-- 	"--preset=canvas",
					-- },
					extensions = {
						["png"] = { "head", "-n", "1" },
						["jpg"] = { "head", "-n", "1" },
						["jpeg"] = { "head", "-n", "1" },
						["gif"] = { "head", "-n", "1" },
						["webp"] = { "head", "-n", "1" },
						["svg"] = { "head", "-n", "1" },
					},
				},
			},
		})
	end
end

local function get_cwd()
	local buf_dir = vim.fn.expand("%:p:h")
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(buf_dir) .. " rev-parse --show-toplevel")[1]
	return (vim.v.shell_error == 0 and git_root) and git_root or buf_dir
end

-- ======  keymap triggers  ====== --
-- <leader>ff: search files
vim.keymap.set("n", "<leader>ff", function()
	ensure_fzf_lua()
	require("fzf-lua").files({ cwd = get_cwd() })
end)

-- <leader>dd: search content (live grep)
vim.keymap.set("n", "<leader>dd", function()
	ensure_fzf_lua()
	require("fzf-lua").live_grep({ cwd = get_cwd() })
end)
