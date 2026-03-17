-- ~/.config/nvim/lua/plugins/opencode.lua
return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    cmd = { "Opencode", "OpenCode" },
    config = function()
      local width = math.floor(vim.o.columns * 0.5)

      -- Configure opencode with custom terminal width
      vim.g.opencode_opts = {
        server = {
          port = 9090,
          start = function()
            require("opencode.terminal").start("opencode --port", { width = width })
          end,
          stop = function()
            require("opencode.terminal").stop()
          end,
          toggle = function()
            require("opencode.terminal").toggle("opencode --port", { width = width })
          end,
        },
      }
      vim.o.autoread = true

      -- Add vim command
      vim.api.nvim_create_user_command("Opencode", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode panel" })

      -- Keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

      -- Operator mappings
      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

      -- Session navigation
      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
    end,
  }
}
