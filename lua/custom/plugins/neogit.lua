return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
    },
    config = function()
      require('neogit').setup()
    end,
  },
}
