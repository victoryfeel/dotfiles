local servers = {
  "lua_ls",
  "rust_analyzer",
  "pylsp",
  "clangd",
  "gopls",
}

-- === 1. LspAttach 事件：当 Buffer 连接到 LSP 服务时激活快捷键与原生 Inlay Hints ===
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = bufnr, silent = true }

    -- 局部按键绑定 (仅在当前激活 LSP 的 Buffer 生效)
    vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gb", "<C-o>", opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ef", vim.lsp.buf.code_action, opts)

    -- 使用 Neovim 0.12+ 原生 Inlay Hints
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
})

-- === 2. 全局诊断按键与图标外观设置 ===
vim.keymap.set("n", "<leader>ek", vim.diagnostic.goto_prev, { silent = true, desc = "上一处诊断" })
vim.keymap.set("n", "<leader>ej", vim.diagnostic.goto_next, { silent = true, desc = "下一处诊断" })

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
})

-- === 3. 按需懒加载依赖与特定服务器配置 ===
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/williamboman/mason.nvim",
      "https://github.com/williamboman/mason-lspconfig.nvim",
      "https://github.com/neovim/nvim-lspconfig",
    })

    -- 基础依赖初始化 (Mason)
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    -- === 特定 LSP 配置 ===

    -- C/C++ (clangd) 恢复高效稳定参数
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--header-insertion=never",
        "--completion-style=detailed",
      },
    })

    -- Python (pylsp) + uv 虚拟环境自适应
    vim.lsp.config("pylsp", {
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
    })

    -- Lua (lua_ls)
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          hint = { enable = true },
          diagnostics = {
            globals = { "vim", "require", "opts", "PackUtils", "jit" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- Go (gopls)
    vim.lsp.config("gopls", {
      settings = {
        ["gopls"] = {
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
          },
        },
      },
    })

    -- 正式启用列表中所有的 LSP 服务
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end,
})
