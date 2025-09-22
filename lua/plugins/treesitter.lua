-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'python', 'markdown' },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
