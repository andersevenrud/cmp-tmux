# compe-tmux

Tmux completion source for [nvim-compe](https://github.com/hrsh7th/nvim-compe).

Sources words from adjacent tmux panes.

## Requirements

* [Neovim](https://github.com/neovim/neovim/)
* [nvim-compe](https://github.com/hrsh7th/nvim-compe)
* [tmux](https://github.com/tmux/tmux)

## Installation

Use your package manager of choice. Examples:

```vim
" dein
dein#add('andersevenrud/compe-tmux')

" plug
Plug 'andersevenrud/compe-tmux'

" Packer
use { 'andersevenrud/compe-tmux' }
```

Then update your compe settings:

```lua
require'compe'.setup {
  -- ...
  source = {
    -- ...
    tmux = true,
  }
}
```

Or using vimL:

```vim
let g:compe.source = {}
let g:compe.source.tmux = v:true
```

## Configuration

To configure options provided by this plugin, change your compe source to the following:

```lua
require'compe'.setup {
  source = {
    tmux = {
      -- option = value
    }
  }
}
```

Or using vimL:

```vim
let g:compe.source = {}
let g:compe.source.tmux = {}
"let g:compe.source.tmux.option = value
```

Available options:

* `all_panes` - Uses all panes as sources, not just the adjacent (default: **false**)

## License

MIT
