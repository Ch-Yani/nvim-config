-- 插件：nvim-osc52
return {
  "ojroques/nvim-osc52",
  config = function()
    local osc52 = require("osc52")
    osc52.setup({
      max_length = 0,    -- 不限制长度（可能会被 Tabby 限制，但不影响正常使用）
      silent = true,     -- 不在命令行显示复制成功提示
      trim = true,
    })

    -- 定义复制函数
    local function copy(lines, _)
      osc52.copy(table.concat(lines, "\n"))
    end

    local function paste()
      return { vim.fn.getreg(""), vim.fn.getregtype("") }
    end

    -- 设置为默认剪贴板
    vim.g.clipboard = {
      name = "osc52",
      copy = {
        ["+"] = copy,
        ["*"] = copy,
      },
      paste = {
        ["+"] = paste,
        ["*"] = paste,
      },
    }
  end,
}

