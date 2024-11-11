local lint = require('lint')
local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { { 'eslint_d', 'eslint' }, { 'prettierd', 'prettier' } },
    typescript = { { 'eslint_d', 'eslint' }, { 'prettierd', 'prettier' } },
    javascriptreact = { { 'eslint_d', 'eslint' }, { 'prettierd', 'prettier' } },
    typescriptreact = { { 'eslint_d', 'eslint' }, { 'prettierd', 'prettier' } },
  },
  format_on_save = {
    timeout_ms = 2750,
    lsp_fallback = true,
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    lint.try_lint()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    conform.format({ bufnr = args.buf, async = true })
  end
})
