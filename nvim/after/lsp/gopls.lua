return {
	settings = {
		gopls = {
			completeUnimported = true,
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				unusedvariable = false,
				useany = true,
			},
			staticcheck = true,
		},
	},
}
