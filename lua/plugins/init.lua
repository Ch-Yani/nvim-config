-- ~/.config/nvim/lua/plugins/init.lua

return {
  -- 颜色主题
  require('plugins.colorscheme'),

  -- 状态栏
  require('plugins.lualine'),

  -- FZF(模块搜索查找)
  require('plugins.fzf-lua'),

  -- LSP (not use)
  --require('plugins.lsp'),

  -- Treesitter (语法高亮)
  require('plugins.treesitter'),

  -- treesitter_context(top 位置显示类)
  require('plugins.treesitter_context'),

  -- vim-oscyank（共享剪切板）
  require('plugins.vim-oscyank'),

}
