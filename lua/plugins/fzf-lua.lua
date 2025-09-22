-- fzf-lua 配置 (lazy.nvim)
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 如果需要图标
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        winopts = {
          height = 0.35,       -- 高度占 35%
          width  = 0.99,       -- 宽度占 99%
          row    = 1.0,        -- 底部对齐 (row=1 表示靠下)
          col    = 0.5,        -- 居中
          border = "rounded",  -- 边框

		  preview = {
			  layout = 'horizontal',   -- 预览布局: vertical/horizontal/flex
			  horizontal = 'right:40%', -- 水平时在右边，占 40% 宽度
			  flip_columns = 120,    -- 小屏幕时自动翻转
		  },

        },
        fzf_opts = {
          ['--layout'] = 'reverse-list',  -- 输入框在上方
        },
        files = {
          previewer = "false",   -- 文件预览器，可改成 false 关闭
          -- 这里禁用图标（如果使用了图标插件）
          file_icons = false,
        },
        grep = {
          rg_opts = "--column --line-number --no-heading --color=always --smart-case",
        },
      })

      local map = vim.keymap.set

      -- 文件 / 缓冲区
      map("n", "<Leader>f", fzf.files, { desc = "FzfLua 查找文件" })
      map("n", "<Leader>b", fzf.buffers, { desc = "FzfLua 查找缓冲区" })

      -- grep 搜索
      map("n", "<Leader>a", fzf.live_grep, { desc = "FzfLua live grep (类似 Ag)" })
      map("n", "<Leader>r", fzf.grep_cword, { desc = "FzfLua grep 光标单词" })

      -- tags / 当前缓冲区搜索
      map("n", "<Leader>t", fzf.btags, { desc = "FzfLua tags (需要 ctags)" })
      map("n", "<Leader>l", fzf.blines, { desc = "FzfLua 当前缓冲区搜索行" })

      -- === 新增 <Leader>e: 当前文件目录 fzf 文件查找 ===
    map("n", "<Leader>e", function()
      local cwd = vim.fn.expand('%:p:h')
      if cwd == "" then
        cwd = vim.fn.getcwd()  -- 如果路径为空，使用当前工作目录
      end

      -- 调试输出 cwd
      print("Current directory: " .. cwd)

      fzf.files({
        cwd = cwd,
        prompt = "CurrentDir> ",
        fzf_opts = {
          ["--layout"] = "reverse-list",  -- 输入框在上方
        },
        winopts = {
          height = 0.28, -- 大约 20 行高度
          row = 1.0,     -- 底部对齐
        },
        actions = {
          ["default"] = function(selected)
            -- 调试输出选中的文件路径
            print("Selected file: " .. selected[1])

            -- 拼接文件路径
            local filepath = cwd .. "/" .. selected[1]  -- 拼接当前目录和选中的文件

            print("Absolute file path: " .. filepath)  -- 输出拼接后的路径

            -- 确保路径正确并打开文件
            vim.cmd("edit " .. filepath)
          end
        }
      })
    end, { desc = "当前文件目录 fzf 文件查找" })
      -- === 模拟原来的 <C-[>X 快捷键 ===
      map("n", "<C-[>f", function()
        fzf.files({ fzf_opts = { ["--query"] = vim.fn.expand("<cfile>") } })
      end, { desc = "查找光标文件名" })

      map("n", "<C-[>a", function()
        fzf.live_grep({ search = vim.fn.expand("<cword>") })
      end, { desc = "live grep 光标单词" })

      map("n", "<C-[>r", fzf.grep_cword, { desc = "grep 光标单词" })

      map("n", "<C-[>t", function()
        fzf.btags({ query = vim.fn.expand("<cword>") })
      end, { desc = "tags 搜索光标单词" })

      map("n", "<C-[>l", function()
        fzf.blines({ query = vim.fn.expand("<cword>") })
      end, { desc = "当前缓冲区搜索光标单词" })
    end,
  },
}

