-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = function()
      -- 这个设置简化了 LSP 配置
      local lsp_zero = require('lsp-zero')
      lsp_zero.on_attach(function(client, bufnr)
        -- 查看 :help lsp-zero-keybindings 获取更多信息
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'lua_ls', 'pyright' }, -- 在这里添加其他语言服务器
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end,
  },

  -- 自动补全
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- 替代 echodoc.vim 用于显示函数签名
  { 'j-hui/fidget.nvim', opts = {} },
}
