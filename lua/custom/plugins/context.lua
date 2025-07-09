return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter', -- Ensure treesitter is already installed
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable context by default
        max_lines = 0, -- Limit the number of lines to show (0 for no limit)
        min_window_height = 0, -- Minimum height to trigger context (0 for no limit)
        patterns = {
          -- Enable context for specific languages
          -- If you want to limit it to certain languages, you can specify here.
          default = {
            'function',
            'method',
            'for_statement',
            'while_statement',
          },
        },
      }
    end,
  },
}
