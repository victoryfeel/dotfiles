--=========  TODO COMMENT  =========--
local P = {
  name = "todo-comments.nvim",
  deps = { "plenary.nvim" },
}

--==============================================--
--=========  lazy-load: event trigger  =========--
--==============================================--
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    PackUtils.load(P, function()
      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,

        keywords = {
          BUG = { icon = " ", color = "#DC2626" },
          TODO = { icon = " ", color = "#2563EB" }, --#FBBF24
          NOTE = { icon = "󱜾 ", color = "#10B981" },
        },
        merge_keywords = false,

        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },

        highlight = {
          multiline = true,
          multiline_pattern = "^.",
          multiline_context = 10,
          before = "",
          keyword = "fg",
          after = "",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },

        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]],
        },
      })

      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { noremap = true, silent = true, desc = "跳转到下一个 TODO/BUG/NOTE" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { noremap = true, silent = true, desc = "跳转到上一个 TODO/BUG/NOTE" })
    end)
  end
})
