return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      style = 'storm', -- 'storm', 'night', 'day', 'moon'
      transparent = true, -- enable transparent background
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        strings = {},
        variables = {},
      },
      sidebars = { 'qf', 'help', 'terminal', 'packer' },
      onedark_style = false, -- not used for tokyonight
      dim_inactive = false,
      lualine_bold = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        native_lsp = true,
        notify = true,
        which_key = true,
      },
    }

    -- Load the colorscheme
    vim.cmd.colorscheme 'tokyonight'

    -- Toggle background transparency
    local bg_transparent = true
    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      require('tokyonight').setup { transparent = bg_transparent }
      vim.cmd.colorscheme 'tokyonight'
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
