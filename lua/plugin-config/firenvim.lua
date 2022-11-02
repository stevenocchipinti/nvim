vim.cmd [[
let g:firenvim_config = {
  \ 'globalSettings': {
  \   'alt': 'all',
  \  },
  \ 'localSettings': {
  \   '.*': {
  \     'cmdline': 'neovim',
  \     'content': 'text',
  \     'priority': 0,
  \     'selector': 'textarea',
  \     'takeover': 'never',
  \   },
  \ }
  \ }

if exists('g:started_by_firenvim')
  set guifont=Caskaydia\ Cove\ Nerd\ Font\ Mono:h20
endif
]]
