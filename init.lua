-- 这个文件是Neovim配置的入口点，它负责引导lazy.nvim插件管理器。
-- ~/.config/nvim/init.lua

-- 将 <space> 设置为 leader 键 [cite: 1]
-- 必须在加载插件之前设置
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 引导启动 lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载核心设置
require('core.options')
require('core.keymaps')

-- 加载插件
require('lazy').setup('plugins')


