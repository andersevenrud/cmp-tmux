# compe-tmux

Tmux completion source for [nvim-compe](https://github.com/hrsh7th/nvim-compe).

*By default this extension uses adjacent panes as sources. See [configuration](#configuration)
to enable all panes.*

## Requirements

* [Neovim](https://github.com/neovim/neovim/)
* [nvim-compe](https://github.com/hrsh7th/nvim-compe)
* [tmux](https://github.com/tmux/tmux)

## Installation

Use your package manager of choice. For example [packer.nvim](https://github.com/wbthomason/packer.nvim):

```vim
use 'andersevenrud/compe-tmux'
```

## Setup

Using Lua:

```lua
require'compe'.setup {
  source = {
    tmux = true,
  }
}
```

Or vimL:

```vim
let g:compe.source.tmux = v:true
```

## Configuration

To configure this extension, change the `tmux` compe source definition as defined below (defaults shown).

Using Lua:

```lua
require'compe'.setup {
  source = {
    tmux = {
      disabled = false,
      all_panes = false,
      kind = 'Text',
    }
  }
}
```

Or using vimL:

```vim
let g:compe.source.tmux = {}
let g:compe.source.tmux.disabled = v:false
let g:compe.source.tmux.all_panes = v:false
let g:compe.source.tmux.kind = "Text"
```

## License

MIT
