local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

-- Moving around windows
map('n', '<C-h>', '<C-W>h', default_opts)
map('n', '<C-j>', '<C-W>j', default_opts)
map('n', '<C-k>', '<C-W>k', default_opts)
map('n', '<C-l>', '<C-W>l', default_opts)

-- Managing tabs
map('n', '<Leader>tn', ':tabnew<CR>', default_opts)
map('n', '<Leader>tc', ':tabclose<CR>', default_opts)
map('n', '<Leader>to', ':tabonly<CR>', default_opts)
map('n', '<Leader>tm', ':tabmove<CR>', default_opts)
map('n', '<Leader>te', ':tabedit <C-r>=expand("%:p:h")<CR>/', default_opts)

-- File system
map('n', '<Leader>cd', ':cd %:p:h<CR>:pwd<CR>', default_opts)
map('n', '<Leader>b', ':NERDTree %<CR>', default_opts)
map('n', '<Leader>gs', ':FzfPreviewGitStatusRpc<CR>', default_opts)
map('n', '<Leader>ff', ':FZF<CR>', default_opts)
map('n', '<Leader>fb', ':Buffers<CR>', default_opts)
map('n', '<Leader>ft', ':Ag<CR>', default_opts)

-- Useful utilities
map('n', '<Leader><CR>', ':noh<CR>', default_opts)
map('n', '<Leader>ss', ':setlocal spell!<CR>', default_opts)

-- Zen mode
map('n', '<Leader>zm', ':ZenMode<CR>', default_opts)
map('n', '<Leader>zh', ':Twilight<CR>', default_opts)
