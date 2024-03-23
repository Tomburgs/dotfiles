local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local copilot, copilot_cmp = require('copilot'), require('copilot_cmp');

local function border(hl_name)
  return {
    { '╭', hl_name },
    { '─', hl_name },
    { '╮', hl_name },
    { '│', hl_name },
    { '╯', hl_name },
    { '─', hl_name },
    { '╰', hl_name },
    { '│', hl_name },
  }
end

copilot.setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

copilot_cmp.setup()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'copilot' },
  },
  window = {
    completion = {
      border = border 'CmpBorder',
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,FloatBorder:Pmenu,Search:None',
      col_offset = -3,
      side_padding = 0,
    },
    documentation = {
      border = border 'CmpDocBorder',
    }
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        symbol_map = { Copilot = '' }
      })(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. (strings[1] or '') .. ' '
      kind.menu = '    (' .. (strings[2] or '') .. ')'

      return kind
    end,
  },
})
