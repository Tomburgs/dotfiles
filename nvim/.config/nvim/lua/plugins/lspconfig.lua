local lsp = require('lspconfig')
local mason, mason_lspconfig = require('mason'), require('mason-lspconfig')
local flutter_tools = require('flutter-tools')
local dap, dap_vscode, dap_widgets, dapui, dap_js =
    require('dap'),
    require('dap.ext.vscode'),
    require('dap.ui.widgets'),
    require('dapui'),
    require('dap-vscode-js')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local xbase = require('xbase')

vim.api.nvim_create_autocmd('FileType', {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
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

    vim.keymap.set('n', '<F1>', dap_widgets.hover, opts)
    vim.keymap.set('n', '<F4>', dap.clear_breakpoints, opts)
    vim.keymap.set('n', '<F5>', dap.continue, opts)
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, opts)
    vim.keymap.set('n', '<F12>', dapui.toggle, opts)
    vim.keymap.set('n', '<F11>', dapui.open, opts)

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
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = true
        end
      })
    end,
  }
})

-- Ignore all but uncaught exceptions by default
dapui.setup({
  reset = true,
})
dap_js.setup({
  debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
  adapters = { 'pwa-node' },
  log_file_path = '/Users/tomsburgmanis/.cache/nvim/js_dap.log',
  log_file_level = vim.log.levels.ERROR,
  log_console_level = vim.log.levels
      .ERROR -- Logging level for output to console. Set to false to disable console output.
})

table.insert(vim._so_trails, "/?.dylib")

local _, err = pcall(function()
  require('dap').set_log_level('ERROR')

  dap_vscode.load_launchjs(nil, { ['pwa-node'] = { 'typescript', 'javascript' } })
end)

if err then
  print('Error loading launch.json: ' .. err)
end

-- null_ls.setup({
--   debug = true,
--   root_dir = null_ls_utils.root_pattern('.git', 'Makefile'),
--   sources = {
--     null_ls.builtins.formatting.stylua,
--     null_ls.builtins.formatting.prettier,
--     null_ls.builtins.code_actions.eslint_d,
--     null_ls.builtins.diagnostics.eslint_d,
--     null_ls.builtins.formatting.eslint_d,
--     null_ls.builtins.completion.spell,
--   },
-- })

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

vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#928374' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#458588' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#83A598' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#B16286' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D8DEE9' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
