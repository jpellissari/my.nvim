return {
  'folke/snacks.nvim',
  optional = true,
  keys = {
    {
      '<leader>np',
      function()
        Snacks.scratch {
          name = 'pomodoro',
          ft = 'markdown',
          icon = '🍅',
          title = 'Focus!!!',
          width = 80,
          height = 0.6,
          file = require('pellissari.helpers.notes').pomodoro_path(),
        }
      end,
      desc = '[N]otes [P]omodoro',
    },
  },
}
