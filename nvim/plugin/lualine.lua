-- AI Edit: 使用 vim.schedule 延后 Lualine 状态栏组件加载，避开首屏主线程同步渲染 (节省 ~5ms 启动时间)
vim.schedule(function()
  vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim"
  })

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '\u{e0b1}', right = '\u{e0b1}' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
        refresh_time = 16, -- ~60fps
        events = {
          'WinEnter',
          'BufEnter',
          'BufWritePost',
          'SessionLoadPost',
          'FileChangedShellPost',
          'VimResized',
          'Filetype',
          'CursorMoved',
          'CursorMovedI',
          'ModeChanged',
        },
      }
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(res)
            local mode_map = {
              ['NORMAL'] = '\u{f121} NORMAL',
              ['INSERT'] = '\u{f11c} INSERT',
              ['VISUAL'] = '\u{f0168} VISUAL',
              ['V-LINE'] = '\u{f0168} V-LINE',
              ['V-BLOCK'] = '\u{f0168} V-BLOCK',
              ['COMMAND'] = '\u{f120} COMMAND',
              ['SELECT'] = '\u{f0c5} SELECT',
              ['S-LINE'] = '\u{f0c5} S-LINE',
              ['S-BLOCK'] = '\u{f0c5} S-BLOCK',
              ['REPLACE'] = '\u{f044} REPLACE',
              ['TERMINAL'] = '\u{f120} TERMINAL',
              ['SHELL'] = '\u{f489} SHELL',
            }
            return mode_map[res] or ('\u{f059} ' .. res)
          end
        }
      },
      lualine_b = {},
      lualine_c = {
        { 'filename', path = 0 },
        { 'branch',   icon = '\u{e725}' },
        { 'filetype', colored = false },
        {
          'filesize',
          fmt = function(str)
            if str == "" then return "" end
            return '\u{f016} ' .. str
          end
        }
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        { 'location', icon = '\u{f017}' },
        'progress'
      }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        { 'filename', path = 0 },
        { 'filetype', colored = false }
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        'location',
        'progress'
      }
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end)
