-- ~/.config/nvim/lua/plugins/treesitter_context.lua
return {
  -- nvim-treesitter 主插件
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "c", "cpp", "lua", "python", "go", "javascript", "typescript", "java"
        },
        highlight = {
          enable = true,        -- 启用语法高亮
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true }, -- 自动缩进
      }
    end
  },

  -- treesitter-context 插件
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup{
        enable = true,              -- 启用
        max_lines = 3,              -- 顶部显示最多 3 行
        min_window_height = 0,      -- 窗口最小高度
        line_numbers = true,        -- 显示行号
        multiline_threshold = 5,    -- 超过 5 行的函数头显示多行
        trim_scope = 'outer',       -- 剪裁显示范围
        mode = 'topline',           -- 顶部显示
        separator = nil,            -- 顶部分隔线，可改为 '─'
      }
    end
  },
}

