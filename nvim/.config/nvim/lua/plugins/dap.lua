local dap, dap_vscode, dap_widgets, dapui, dap_js, dap_virtual_text =
    require('dap'),
    require('dap.ext.vscode'),
    require('dap.ui.widgets'),
    require('dapui'),
    require('dap-vscode-js'),
    require('nvim-dap-virtual-text')

-- { reset = true }
dapui.setup()
dap_virtual_text.setup()
dap_js.setup({
  debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
  adapters = { 'pwa-node' },
  log_file_path = '/Users/tomsburgmanis/.cache/nvim/js_dap.log',
  log_file_level = vim.log.levels.ERROR,
  log_console_level = vim.log.levels.ERROR
})

table.insert(vim._so_trails, "/?.dylib")

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<Leader>di', dap_widgets.hover, opts)
vim.keymap.set('n', '<Leader>dc', dap.continue, opts)
vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<Leader>dB',
  function()
    vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(input)
      dap.set_breakpoint(input)
    end)
  end, opts)
vim.keymap.set('n', '<Leader>du', dapui.toggle, opts)


-- Node / JavaScript setup
if not dap.adapters["node"] then
  dap.adapters["node"] = function(cb, config)
    if config.type == "node" then
      config.type = "pwa-node"
    end
    local nativeAdapter = dap.adapters["pwa-node"]
    if type(nativeAdapter) == "function" then
      nativeAdapter(cb, config)
    else
      cb(nativeAdapter)
    end
  end
end

local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

dap_vscode.load_launchjs(nil,
  { ['pwa-node'] = js_filetypes, ['node'] = js_filetypes })
