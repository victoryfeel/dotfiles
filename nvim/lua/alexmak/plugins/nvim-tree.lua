local is_loaded = false

vim.keymap.set("n", "<leader>e", function()
  if not is_loaded then
    -- 仅在第一次按键时执行下载、加载和初始化
    vim.pack.add({ "https://www.github.com/nvim-tree/nvim-tree.lua" })

    require("nvim-tree").setup({
      view = { width = 35 },
      filters = { dotfiles = false },
      renderer = { group_empty = true },
    })

    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

    is_loaded = true
  end
  -- 以当前文件所在 git repo 根目录为树根，非 git 项目则用文件所在目录
  local buf_dir = vim.fn.expand("%:p:h")
  local git_root = vim.fs.root(0, ".git")
  local tree_root = git_root or buf_dir
  require("nvim-tree.api").tree.toggle({ path = tree_root, find_file = true })
end, { desc = "Toggle NvimTree" })
