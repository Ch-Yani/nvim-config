return {
  "ojroques/vim-oscyank",
  config = function()
    -- =======================================================
    -- 1. 插件参数设置
    -- =======================================================
    -- 设置最大复制字符数，1000000 足够覆盖几千行代码，解决 40行截断问题
    vim.g.oscyank_max_length = 1000000 
    -- 静默模式，复制时不显示 "Copied 123 chars..." 这种消息
    vim.g.oscyank_silent = true        
    
    -- =======================================================
    -- 2. 自动触发逻辑 (核心)
    -- =======================================================
    -- 创建一个自动命令：每当发生 Yank (复制) 动作后执行
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("OSCYank", { clear = true }),
      pattern = "*",
      callback = function()
        -- 检查：只有当操作是复制('y') 且 目标寄存器是系统剪贴板('+') 时才触发
        if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
          -- 调用 vim-oscyank 的核心命令，将 + 寄存器的内容发送给 Tabby
          vim.cmd('OSCYankRegister +')
        end
      end,
    })

    -- =======================================================
    -- 3. 剪贴板防报错设置 (重要)
    -- =======================================================
    -- 在 SSH 环境中，通常没有 xclip/xsel。
    -- 如果不设置这个，按 "+y 时 Neovim 可能会报错说找不到剪贴板提供程序。
    -- 我们定义一个"虚假"的剪贴板，让 Neovim 以为复制成功了，
    -- 实际上真正的传输工作是由上面的 "TextYankPost" 完成的。
    vim.g.clipboard = {
      name = 'fake-clipboard',
      copy = {
        ["+"] = function() end, -- 啥都不做，依靠上面的 autocmd 处理
        ["*"] = function() end,
      },
      paste = {
        -- 粘贴逻辑：直接返回寄存器里的内容 (如果只是单纯想在 nvim 内粘贴)
        -- 如果需要从 Windows 粘贴回 Nvim，通常 Shift+Insert 更快
        ["+"] = function() return {vim.fn.getreg('+'), vim.fn.getregtype('+')} end,
        ["*"] = function() return {vim.fn.getreg('*'), vim.fn.getregtype('*')} end,
      },
      cache_enabled = 0,
    }

    -- =======================================================
    -- 4. 快捷键映射 (你要求的配置)
    -- =======================================================
    --local map = vim.keymap.set
    --local opts = { noremap = true, silent = true }

    -- 视觉模式选中后，按 y 复制到系统剪贴板 (触发上面的 TextYankPost)
    --map('v', 'y', '"+y', { desc = '复制到系统剪贴板 (Window/Tabby)', unpack(opts) })

    -- 正常模式下，按 p 从系统剪贴板粘贴 (实际上是粘贴 nvim 寄存器内容)
    -- 注意：要在 Tabby 里把 Windows 的内容粘贴进 Nvim，
    -- 建议直接使用 Tabby 的快捷键 (通常是 Ctrl+Shift+V 或 鼠标右键)
    --map('n', 'p', '"+p', { desc = '从系统剪贴板粘贴', unpack(opts) })
  end,
}
