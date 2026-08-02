return {
	on_init = function(client)
		local root_dir = client.config.root_dir
		if root_dir then
			local venv_python = root_dir .. "/.venv/bin/python"
			if vim.fn.filereadable(venv_python) == 1 then
				client.config.settings.pylsp.plugins.jedi.environment = venv_python
				client.notify("workspace/didChangeConfiguration", {
					settings = client.config.settings,
				})
			end
		end
		return true
	end,
	settings = {
		pylsp = {
			plugins = {
				jedi = { environment = nil },
			},
		},
	},
}
