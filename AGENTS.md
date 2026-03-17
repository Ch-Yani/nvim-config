# AGENTS.md - Neovim Configuration

This is a Neovim configuration repository using Lua. It uses lazy.nvim as the plugin manager.

## Project Structure

```
~/.config/nvim/
├── init.lua              # Entry point
├── lazy-lock.json        # Plugin lockfile
├── lua/
│   ├── core/
│   │   ├── options.lua   # Neovim options/settings
│   │   └── keymaps.lua   # Key mappings
│   └── plugins/
│       ├── init.lua      # Plugin list
│       ├── colorscheme.lua
│       ├── fzf-lua.lua
│       ├── lsp.lua
│       ├── lualine.lua
│       ├── nvim-osc52.lua
│       ├── opencode.lua
│       ├── treesitter.lua
│       └── treesitter_context.lua
```

## Build/Test Commands

Since this is a Neovim configuration (not a compiled project), there are no traditional build commands.

## Validate Configuration

```bash
# Test configuration loads (headless mode)
nvim --headless -c "lua print('Config OK')" -c "quit"

# Check for Lua syntax errors
luac -p lua/**/*.lua

# Check plugin loading errors
nvim +":Lazy" +"qa!"

# Source init.lua without restarting
nvim --headless -c "source ~/.config/nvim/init.lua" -c "qa!"
```

## Code Style Guidelines

### General Conventions

- **Language**: Lua (Neovim config)
- **Indentation**: 2 spaces (not tabs)
- **Line length**: Soft limit 120 characters
- **File encoding**: UTF-8
- **End files with newline**: Yes

### Naming Conventions

- **Variables**: `snake_case` (e.g., `local lazypath`, `local opt`)
- **Functions**: `snake_case` (e.g., `function set_indent(width, use_tabs)`)
- **Tables/Modules**: `snake_case`
- **File names**: `snake_case.lua` (e.g., `treesitter_context.lua`)

### Import Style

```lua
-- Core modules
local opt = vim.opt
local map = vim.keymap.set

-- Plugin specs (use require in init.lua)
return {
  require('plugins.colorscheme'),
  require('plugins.lualine'),
}
```

### Keymap Definitions

Use `vim.keymap.set` with explicit options:

```lua
-- Recommended format
map('n', '<leader>key', '<cmd>Command<CR>', { desc = 'Description' })

-- Or with function
map('n', '<leader>key', function()
  -- code here
end, { desc = 'Description' })
```

### Plugin Specifications

Follow lazy.nvim spec format:

```lua
return {
  'owner/repo',
  event = 'VeryLazy',  -- or 'BufReadPost', etc.
  config = function()
    require('plugin').setup({ opts = true })
  end,
  dependencies = { 'other/plugin' },
}
```

### Options/Settings

```lua
-- Use vim.opt for options
vim.opt.number = true
vim.opt.expandtab = true

-- Use vim.cmd for commands
vim.cmd('filetype plugin on')

-- Use vim.api for advanced features
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    -- handler
  end,
})
```

### Error Handling

```lua
-- Check if path exists before requiring
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', url, lazypath })
end
```

### Comments

- Use English comments for general documentation
- Chinese comments are acceptable for personal notes
- Include descriptive `desc` field in keymaps for `:map` output

## Common Tasks

### Add a New Plugin

1. Add spec to `lua/plugins/init.lua`
2. Create config file in `lua/plugins/<name>.lua`
3. Restart Neovim or run `:Lazy sync`

### Modify Keymaps

Edit `lua/core/keymaps.lua`. Use `<leader>` prefix for custom mappings.

### Change Settings

Edit `lua/core/options.lua`. Use `vim.opt` for boolean/numeric options.

## Additional Resources

- [Neovim Lua Guide](https://neovim.io/doc/user/lua.html)
- [lazy.nvim Documentation](https://lazy.nvim.org/)
- [vim.keymap.set](https://neovim.io/doc/user/lua.html#vim.keymap.set())
