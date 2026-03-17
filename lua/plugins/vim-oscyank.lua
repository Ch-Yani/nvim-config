-- ~/.config/nvim/lua/plugins/vim-oscyank.lua
return {
  "ojroques/vim-oscyank",
  config = function()
    vim.g.oscyank_max_length = 1000000
    vim.g.oscyank_silent = true

    -- Auto-copy to system clipboard on yank
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("OSCYank", { clear = true }),
      pattern = "*",
      callback = function()
        if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
          vim.cmd('OSCYankRegister +')
        end
      end,
    })
  end,
}
