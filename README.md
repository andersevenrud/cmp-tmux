# compe-tmux

Tmux completion source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).

*By default this extension uses adjacent panes as sources. See [configuration](#configuration)
to enable all panes.*

## Requirements

* [Neovim](https://github.com/neovim/neovim/)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [tmux](https://github.com/tmux/tmux)

## Installation

Use your package manager of choice. For example [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'andersevenrud/compe-tmux',
  branch = 'cmp'
}
```

## Setup

```lua
require'cmp'.setup {
  sources = {
    { name = 'tmux' }
  }
}
```

## Configuration

To configure this extension, add an options table (defaults shown):

```lua
require'compe'.setup {
  sources = {
    {
      name = 'tmux',
      opts = {
        all_panes = false,
      }
    }
  }
}
```

## License

MIT
