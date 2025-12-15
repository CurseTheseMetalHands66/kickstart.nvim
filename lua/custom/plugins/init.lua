-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Seamless navigation between tmux panes and vim splits
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
    },
    keys = {
      { '<C-h>', '<cmd>TmuxNavigateLeft<cr>' },
      { '<C-j>', '<cmd>TmuxNavigateDown<cr>' },
      { '<C-k>', '<cmd>TmuxNavigateUp<cr>' },
      { '<C-l>', '<cmd>TmuxNavigateRight<cr>' },
    },
  },

  -- Scope buffers to tabs
  {
    'tiagovla/scope.nvim',
    event = 'VimEnter',
    opts = {},
  },

  -- Tabline plugin
  {
    'romgrk/barbar.nvim',
    event = 'VimEnter',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = true,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      icons = {
        buffer_index = false,
        buffer_number = false,
        button = '',
        filetype = { enabled = vim.g.have_nerd_font },
        separator = { left = '▎', right = '' },
        modified = { button = '●' },
        pinned = { button = '', filename = true },
        inactive = { button = '×' },
      },
    },
    keys = {
      { '<S-h>', '<cmd>BufferPrevious<cr>', desc = 'Previous buffer' },
      { '<S-l>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
      { '<leader>bp', '<cmd>BufferMovePrevious<cr>', desc = 'Move buffer left' },
      { '<leader>bn', '<cmd>BufferMoveNext<cr>', desc = 'Move buffer right' },
      { '<leader>1', '<cmd>BufferGoto 1<cr>', desc = 'Go to buffer 1' },
      { '<leader>2', '<cmd>BufferGoto 2<cr>', desc = 'Go to buffer 2' },
      { '<leader>3', '<cmd>BufferGoto 3<cr>', desc = 'Go to buffer 3' },
      { '<leader>4', '<cmd>BufferGoto 4<cr>', desc = 'Go to buffer 4' },
      { '<leader>5', '<cmd>BufferGoto 5<cr>', desc = 'Go to buffer 5' },
      { '<leader>6', '<cmd>BufferGoto 6<cr>', desc = 'Go to buffer 6' },
      { '<leader>7', '<cmd>BufferGoto 7<cr>', desc = 'Go to buffer 7' },
      { '<leader>8', '<cmd>BufferGoto 8<cr>', desc = 'Go to buffer 8' },
      { '<leader>9', '<cmd>BufferGoto 9<cr>', desc = 'Go to buffer 9' },
      { '<leader>0', '<cmd>BufferLast<cr>', desc = 'Go to last buffer' },
      { '<leader>bP', '<cmd>BufferPin<cr>', desc = 'Pin buffer' },
      { '<leader>bc', '<cmd>BufferClose<cr>', desc = 'Close buffer' },
      { '<leader>bC', '<cmd>BufferCloseAllButCurrent<cr>', desc = 'Close all but current' },
      { '<leader>bb', '<cmd>BufferPick<cr>', desc = 'Pick buffer' },
      { '<leader>bd', '<cmd>BufferOrderByDirectory<cr>', desc = 'Order by directory' },
      { '<leader>bl', '<cmd>BufferOrderByLanguage<cr>', desc = 'Order by language' },
      { '<leader>bv', '<cmd>vsplit | BufferClose<cr>', desc = 'Move buffer to vertical split' },
      { '<leader>bs', '<cmd>split | BufferClose<cr>', desc = 'Move buffer to horizontal split' },
      {
        '<leader>bt',
        function()
          local file = vim.fn.expand('%:p')
          if file == '' then
            vim.notify('No file to move', vim.log.levels.WARN)
            return
          end
          vim.cmd('BufferClose')
          vim.cmd('tabnew ' .. vim.fn.fnameescape(file))
        end,
        desc = 'Move buffer to new tab',
      },
      {
        '<leader>bT',
        function()
          local tabs = vim.api.nvim_list_tabpages()
          if #tabs < 2 then
            vim.notify('No other tabs available', vim.log.levels.WARN)
            return
          end
          local choices = {}
          for i, tab in ipairs(tabs) do
            if tab ~= vim.api.nvim_get_current_tabpage() then
              table.insert(choices, string.format('%d', i))
            end
          end
          vim.ui.select(choices, { prompt = 'Move to tab:' }, function(choice)
            if choice then
              vim.cmd('ScopeMoveBuf ' .. choice)
            end
          end)
        end,
        desc = 'Move buffer to existing tab',
      },
    },
  },
}
