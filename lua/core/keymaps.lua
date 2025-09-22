-- ~/.config/nvim/lua/core/keymaps.lua

local map = vim.keymap.set


-- 窗口导航
map('n', '<c-j>', '<c-w>j', { desc = '移动到下方窗口' }) 
map('n', '<c-k>', '<c-w>k', { desc = '移动到上方窗口' }) 
map('n', '<c-h>', '<c-w>h', { desc = '移动到左侧窗口' }) 
map('n', '<c-l>', '<c-w>l', { desc = '移动到右侧窗口' }) 

-- 系统剪贴板
map('v', '<leader><leader>y', '"+y', { desc = '复制到系统剪贴板' }) -- [cite: 8]
map('n', '<leader><leader>p', '"+p', { desc = '从系统剪贴板粘贴' }) -- [cite: 8]


-- 功能键映射
map('n', '<F7>', ':set number<CR>', { desc = '开启行号' }) -- [cite: 15]
map('n', '<F9>', ':set nonu<CR>', { desc = '关闭行号' }) -- [cite: 15]
map('n', '<F10>', ':set cc=<CR>', { desc = '清除颜色列' }) -- [cite: 15]

-- Quickfix 列表导航
---- next buffer
map('n', '<Tab>', ':bn<CR>', { desc = '下一个buffer窗口' })
map('n', '<leader>d', ':bdelete<CR>', { desc = '关闭当前buffer' })
map('n', '<leader>cn', ':cnext<CR>', { desc = 'Quickfix 下一项' }) -- [cite: 15]
map('n', '<leader>cp', ':cprev<CR>', { desc = 'Quickfix 上一项' }) -- [cite: 15]
map('n', '<leader>cl', ':clist<CR>', { desc = '显示 Quickfix 列表' }) -- [cite: 15]
map('n', '<leader>cf', ':crewind<CR>', { desc = 'Quickfix 第一项' }) -- [cite: 15]

-- 自定义缩进函数 (从 vimscript 翻译而来)
local function set_indent(width, use_tabs) -- [cite: 16, 17]
  vim.opt.tabstop = width
  vim.opt.shiftwidth = width
  if use_tabs then
    vim.opt.noexpandtab = true
  else
    vim.opt.expandtab = true
  end
  print('缩进已设置为 ' .. width .. ' ' .. (use_tabs and '个制表符' or '个空格'))
end

map('n', '<Leader>2', function() set_indent(2, true) end, { desc = '设置缩进为2个制表符' }) -- [cite: 17]
map('n', '<Leader>4', function() set_indent(4, true) end, { desc = '设置缩进为4个制表符' }) -- [cite: 17]
map('n', '<Leader>8', function() set_indent(8, true) end, { desc = '设置缩进为8个制表符' }) -- [cite: 17]
map('n', '<Leader><Leader>2', function() set_indent(2, false) end, { desc = '设置缩进为2个空格' }) -- [cite: 17]
map('n', '<Leader><Leader>4', function() set_indent(4, false) end, { desc = '设置缩进为4个空格' }) -- [cite: 17]
map('n', '<Leader><Leader>8', function() set_indent(8, false) end, { desc = '设置缩进为8个空格' }) -- [cite: 17]

-- 代码折叠
map('n', '<leader>z', 'za', { desc = '切换代码折叠' }) -- [cite: 18, 19]

-- LSP 映射 (替代 Cscope)
map('n', '<C-[>s', vim.lsp.buf.signature_help, { desc = 'LSP 显示函数签名' }) -- [cite: 15]
map('n', '<C-[>g', vim.lsp.buf.definition, { desc = 'LSP 跳转到定义' }) -- [cite: 15]
map('n', '<C-[>c', vim.lsp.buf.incoming_calls, { desc = 'LSP 显示调用方' }) -- [cite: 15]
map('n', '<C-[>e', vim.diagnostic.open_float, { desc = 'LSP 显示行诊断' }) -- [cite: 15]
map('n', '<C-[>i', vim.lsp.buf.implementation, { desc = 'LSP 跳转到实现' }) -- [cite: 15]
map('n', '<C-[>d', vim.lsp.buf.type_definition, { desc = 'LSP 跳转到类型定义' }) -- [cite: 15]
map('n', '<C-[>r', vim.lsp.buf.references, { desc = 'LSP 查找引用' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP 跳转到声明' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP 显示悬浮文档' })
