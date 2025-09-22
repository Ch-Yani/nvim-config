-- ~/.config/nvim/lua/plugins/lualine.lua

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'ryanoasis/vim-devicons' }, -- [cite: 7]
  config = function()
    require('lualine').setup({
      options = {
        --theme = 'bubblegum', -- 您选择的 airline 主题 [cite: 9]
        component_separators = { left = '|', right = '|' }, -- [cite: 10, 11]
        section_separators = { left = ' ', right = ' ' }, -- [cite: 9, 10, 11]
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { {'filename', path = 1 }}, -- 0: 文件名, 1: 相对路径, 2: 全路径
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
--      tabline = {
--        lualine_a = {'tabs'},
--        lualine_z = {'windows'},
--      },
--      extensions = {'quickfix', 'nvim-tree'}
    })
  end,
}
