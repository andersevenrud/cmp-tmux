if exists('g:loaded_cmp_tmux')
  finish
endif
let g:loaded_cmp_tmux = v:true

lua require'cmp'.register_source('tmux', require'cmp_tmux')
