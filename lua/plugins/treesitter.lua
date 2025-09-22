return {
  -- Treesitter itself
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'cmake',
        'css',
        'dockerfile',
        'gitignore',
        'go',
        'graphql',
        'groovy',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'sql',
        'terraform',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  -- Autotag plugin (separate entry)
  {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter', -- ensure it loads after Treesitter
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
