-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = true,
        color_overrides = {
          vscBack = "#1e1e1e", -- VS Code 经典深灰色
        },
        group_overrides = {
          -- 精确匹配 VS Code 样式
          TreesitterContext = { bg = "#2d2d30" }, -- VS Code 的活动标题栏颜色
        },
      })
      vim.cmd.colorscheme("vscode")
    end,
  }
}
