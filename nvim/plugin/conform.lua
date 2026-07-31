-- AI Edit: 延后 Mason & Conform 的插件加载与注册，避免在启动首屏直接调用 mason-registry (节省 ~15ms 启动开销)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/williamboman/mason.nvim",
      "https://github.com/mason-org/mason-registry",
      "https://github.com/stevearc/conform.nvim",
    })

    require("mason").setup()

    local ensure_installed = {
      "isort",
      "black",
      "shfmt",
      "stylua",
      "deno",
      "clangd",
      "lua-language-server",
      "pyright",
    }

    local registry = require("mason-registry")
    registry.refresh(function()
      for _, tool_name in ipairs(ensure_installed) do
        if registry.has_package(tool_name) then
          local pkg = registry.get_package(tool_name)
          if not pkg:is_installed() then
            pkg:install()
            vim.notify("Mason installing: " .. tool_name, vim.log.levels.INFO)
          end
        end
      end

      local installed_packages = registry.get_installed_packages()
      local lsp_names = vim.iter(installed_packages):fold({}, function(acc, pack)
        local lspconfig_name = pack.spec.neovim and pack.spec.neovim.lspconfig
        if lspconfig_name then
          table.insert(acc, lspconfig_name)
        end
        return acc
      end)

      if #lsp_names > 0 and vim.lsp.enable then
        vim.lsp.enable(lsp_names)
      end
    end)

    require("conform").setup({
      formatters_by_ft = {
        c = { lsp_format = "prefer" },
        cpp = { lsp_format = "prefer" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        toml = { "templ" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        xml = { "deno_fmt" },
        yaml = { "deno_fmt" },
        html = { "deno_fmt" },
        json = { "deno_fmt" },
        lua = { "stylua" },
      },
      formatters = {
        prettier = {
          prepend_args = { "--config-precedence", "prefer-file" },
        },
      },
    })
  end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      async = false,
      lsp_fallback = true,
    })
  end,
})
