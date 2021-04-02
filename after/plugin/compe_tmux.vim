if exists('g:loaded_compe_tmux')
  finish
endif
let g:loaded_compe_tmux = v:true

if exists('g:loaded_compe')
  lua require'compe'.register_source('tmux', require'compe_tmux')
endif
