return {
  {
    'ibhagwan/fzf-lua',
    keys = {
      {
        '<leader><leader>',
        function()
          require('fzf-lua').files()
        end,
      },
      {
        '<leader>/',
        function()
          require('fzf-lua').live_grep()
        end,
      },
      {
        '<leader>l',
        function()
          require('fzf-lua').lines()
        end,
      },
    },
    dependencies = { 'nvim-lspconfig' }, -- Load before LSP
    priority = 100, -- Higher priority to load early
    opts = {
      'max-perf',
    },
  },
}
