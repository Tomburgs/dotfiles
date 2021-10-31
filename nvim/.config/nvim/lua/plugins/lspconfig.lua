local g = vim.g
local exec = vim.api.nvim_exec
local lsp = require('lspconfig')
local coq = require('coq')
local diagnostic = require('null-ls')
local signature = require('lsp_signature')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  signature.on_attach()

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>gsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>gtd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>ri', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    exec([[
      augroup LspAutocommands
      autocmd! * <buffer>
      autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
      augroup END
    ]], true)
  end
end

local lspEnsureCapabilities = coq.lsp_ensure_capabilities({
  on_attach = on_attach
})

local typescriptFiletypes = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

diagnostic.config({
  sources = {
    diagnostic.builtins.diagnostics.eslint_d.with({
      filetypes = typescriptFiletypes
    }),
    diagnostic.builtins.formatting.prettier.with({
      filetypes = typescriptFiletypes
    }),
  }
})

lsp['null-ls'].setup(lspEnsureCapabilities)
lsp.gopls.setup(lspEnsureCapabilities)
lsp.graphql.setup(lspEnsureCapabilities)
lsp.stylelint_lsp.setup(lspEnsureCapabilities)
lsp.tsserver.setup(coq.lsp_ensure_capabilities({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end
}))

g.coq_settings = {
  keymap = {
    jump_to_mark = '<C-N-O-O-P>noop'
  },
  clients = {
    lsp = {
      resolve_timeout = 200
    }
  }
}
