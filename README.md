# compe-tmux

Tmux completion source for [nvim-compe](https://github.com/hrsh7th/nvim-compe).

Sources words from adjacent tmux panes.

## Requirements

* [Neovim](https://github.com/neovim/neovim/)
* [nvim-compe](https://github.com/hrsh7th/nvim-compe)
* [tmux](https://github.com/tmux/tmux)

## Installation

```vim
Plug 'andersevenrud/compe-tmux'


lua << EOF
require'compe'.setup {
  -- ...
  source = {
    -- ...
    tmux = true,
  }
}
EOF
```

## Credit

* [completion-tmux](https://github.com/albertoCaroM/completion-tmux)

## License

MIT
