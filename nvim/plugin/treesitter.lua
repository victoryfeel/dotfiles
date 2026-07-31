vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" then
      vim.cmd("TSUpdate")
    end
  end,
})

-- AI Edit: 纯原生 Treesitter 高亮启用，避免在 FileType 时同步执行同步逻辑或反复检测失败
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NativeTreesitterSetup", { clear = true }),
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    -- 过滤无效 buffer, 终端, 以及 yazi
    if ft == "" or ft == "yazi" or vim.bo[buf].buftype ~= "" then
      return
    end
    -- 过滤大型文件 (> 100kb)
    local max_filesize = 100 * 1024
    local filepath = vim.api.nvim_buf_get_name(buf)
    local ok, stats = pcall(vim.uv.fs_stat, filepath)
    if ok and stats and stats.size > max_filesize then
      return
    end

    -- 获取标准化的语言名称并启用原生高亮
    local lang = vim.treesitter.language.get_lang(ft) or ft
    pcall(vim.treesitter.start, buf, lang)
  end,
})
