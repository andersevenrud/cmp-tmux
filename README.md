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

## Configuration

To configure options provided by this plugin, change your compe source to the following:

```vim
lua << EOF
require'compe'.setup {
  source = {
    tmux = {
      -- Options goes here
    }
  }
}
EOF
```

Available options:

* `all_panes = true` - Uses all panes as sources, not just the adjacent

## Credit

* [completion-tmux](https://github.com/albertoCaroM/completion-tmux)

## License

MIT
