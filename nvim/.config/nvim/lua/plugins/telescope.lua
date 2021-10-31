local actions = require('telescope.actions')
local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values
local flatten = vim.tbl_flatten

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  },
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
      }
    },
    vimgrep_arguments = {
      'ag',
      '--ignore-case',
      '--hidden',
      '--literal',
      '--vimgrep',
    }
  }
})

telescope.load_extension('fzf')
