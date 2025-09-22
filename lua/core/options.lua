-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt -- 方便后续书写

-- 通用设置
-- 下面这些是命令，不是选项，需要用 vim.cmd() 设置
vim.cmd('filetype on') -- 设置开启文件类型侦测
vim.cmd('filetype plugin on') -- 设置加载对应文件类型的插件
vim.cmd('syntax on') -- 开启语法高亮功能

opt.termguicolors = true -- 在TUI中启用24位RGB颜色
-- opt.t_Co = '256' -- 在启用 termguicolors 后已无需此选项
opt.cmdheight = 1 -- 设置命令行的高度为1
opt.showcmd = true -- select模式下显示选中的行数
opt.ruler = true -- 总是显示光标位置
opt.laststatus = 2 -- 总是显示状态栏
opt.number = true -- 开启行号显示
opt.cursorline = true -- 高亮显示当前行
opt.whichwrap:append('<,>,h,l') -- 设置光标键跨行
opt.ttimeoutlen = 0 -- 设置<ESC>键响应时间
opt.virtualedit = 'block,onemore' -- 允许光标出现在最后一个字符的后面

-- 缩进和格式化
opt.autoindent = true -- 设置自动缩进
opt.cindent = true -- 设置使用C/C++语言的自动缩进方式
opt.cinoptions = 'g0,:0,N-s,(0' -- 设置C/C++语言的具体缩进方式
opt.smartindent = true -- 智能的选择对其方式
vim.cmd('filetype indent on') -- 自适应不同语言的智能缩进
opt.expandtab = true -- 将制表符扩展为空格
opt.tabstop = 4 -- 设置编辑时制表符占用空格数
opt.shiftwidth = 4 -- 设置格式化时制表符占用空格数
opt.softtabstop = 4 -- 设置4个空格为制表符
opt.smarttab = true -- 在行和段开始处使用制表符
opt.backspace = 'indent,eol,start' -- 让退格键可以删除更多内容
opt.sidescroll = 10 -- 设置向右滚动字符数
opt.foldenable = false -- 禁用折叠代码
opt.mouse = "" --关闭鼠标
-- 代码补全
opt.wildmenu = true -- vim自身命名行模式智能补全
opt.completeopt = 'menu,menuone,noselect' -- 补全时不显示预览窗口

-- 搜索设置
opt.hlsearch = true -- 高亮显示搜索结果
opt.incsearch = true -- 开启实时搜索功能
opt.ignorecase = true -- 搜索时大小写不敏感
opt.smartcase = true -- 如果搜索模式包含大写字母，则覆盖ignorecase


-- 编码设置
opt.encoding = 'utf-8' -- 设置默认编码
opt.fileencodings = 'utf-8,ucs-bom,gbk,cp936,gb2312,gb18030'

-- 剪贴板
-- opt.clipboard:append('unnamedplus') -- 使用系统剪贴板

-- 打开文件时跳转到最后编辑的位置
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line('$') then
      vim.cmd('normal! g`"') -- 跳转到上次光标位置
    end
  end,
})
