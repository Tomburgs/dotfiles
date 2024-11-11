local lsp = require('lspconfig')
local mason, mason_lspconfig = require('mason'), require('mason-lspconfig')
local flutter_tools = require('flutter-tools')
local dap, dap_vscode =
    require('dap'),
    require('dap.ext.vscode')
local border_util = require('utils.border')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local xbase = require('xbase')

vim.api.nvim_create_autocmd('FileType', {
  buffer = vim.buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})

local border = border_util.border('FloatBorder')

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = border,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = border,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { noremap = true, silent = true, buffer = ev.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<Leader>i', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>gsh', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>gtd', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<Leader>af', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    'vtsls',
    'html',
    'gopls',
    'lua_ls',
    'rust_analyzer'
  },
  handlers = {
    function(server)
      lsp[server].setup({
        capabilities = lsp_capabilities,
        on_attach = function(client)
          client.server_capabilities.document_formatting = true
        end
      })
    end,
  }
})

flutter_tools.setup {
  lsp = {
    capabilities = lsp_capabilities,
    settings = {
      lineLength = 150,
    },
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
    exception_breakpoints = { 'uncaught' },
    register_configurations = function(_)
      dap.configurations.dart = {}
      dap_vscode.load_launchjs()
    end,
  },
}


lsp.sourcekit.setup({
  capabilities = lsp_capabilities,
})
xbase.setup({
  --- Mappings
  mappings = {
    --- Whether xbase mapping should be disabled.
    enable = true,
    --- Open build picker. showing targets and configuration.
    build_picker = '<leader>p', --- set to 0 to disable
    --- Open run picker. showing targets, devices and configuration
    run_picker = '<leader>r',   --- set to 0 to disable
    --- Open watch picker. showing run or build, targets, devices and configuration
    watch_picker = '<leader>s', --- set to 0 to disable
    --- A list of all the previous pickers
    all_picker = '<leader>ef',  --- set to 0 to disable
    --- horizontal toggle log buffer
    toggle_split_log_buffer = '<leader>ls',
    --- vertical toggle log buffer
    toggle_vsplit_log_buffer = '<leader>lv',
  },
})
