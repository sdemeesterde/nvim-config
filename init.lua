require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
--   local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
--   if vim.v.shell_error ~= 0 then
--     error('Error cloning lazy.nvim:\n' .. out)
--   end
-- end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
  require 'plugins.neotree',
  require 'plugins.colortheme',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.misc',
  require 'plugins.comment',
  require 'plugins.rust',
}

local last_win = nil
local last_pos = nil

-- Save last window + cursor position if it's not Neo-tree
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(buf)
    if not bufname:match 'neo%-tree' then
      last_win = vim.api.nvim_get_current_win()
      last_pos = vim.api.nvim_win_get_cursor(0)
    end
  end,
})

-- Smart toggle between Neo-tree and last file
vim.keymap.set('n', '<leader>t', function()
  local bufname = vim.api.nvim_buf_get_name(0)

  if bufname:match 'neo%-tree' and last_win and vim.api.nvim_win_is_valid(last_win) then
    -- Switch back to last file window and restore cursor
    vim.api.nvim_set_current_win(last_win)
    if last_pos then
      vim.api.nvim_win_set_cursor(0, last_pos)
    end
  else
    -- Focus Neo-tree
    vim.cmd 'Neotree focus'
  end
end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-w>', function()
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd 'b#' -- go to previous buffer
  vim.api.nvim_buf_delete(current_buf, { force = true })
end, { noremap = true, silent = true })
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.keymap.set('n', '<space>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J' -- In my config I use k to go downward in view mode
  vim.api.nvim_win_set_height(0, 5)
end)

-- Force all windows to have NO top bar
vim.opt.winbar = nil
vim.opt.showtabline = 0

-- Specifically tell Neo-tree to be clean
-- (In case other plugins try to force a bar into it)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    vim.opt_local.winbar = nil
  end,
})
