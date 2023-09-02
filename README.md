# cmp-tmux

Tmux completion source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).

**If you're looking for a [nvim-compe](https://github.com/hrsh7th/nvim-compe) version of this extension, use the [following branch](https://github.com/andersevenrud/compe-tmux/tree/compe)**.

> This extension [pulls text from your current tmux session](https://github.com/andersevenrud/cmp-tmux/issues/14#issuecomment-924877836)
> and provides it as a completion source.
>
> *By default this extension uses adjacent panes as sources. See [configuration](#configuration) to enable all panes.*

## Requirements

* [Neovim](https://github.com/neovim/neovim/)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [tmux](https://github.com/tmux/tmux)

## Installation

Use your package manager of choice. For example [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'andersevenrud/cmp-tmux'
}
```

## Setup

```lua
require('cmp').setup({
  sources = {
    { name = 'tmux' }
  }
})
```

## Configuration

To configure this extension, add an options table (defaults shown):

```lua
require('cmp').setup({
  sources = {
    {
      name = 'tmux',
      option = {
        -- Source from all panes in session instead of adjacent panes
        all_panes = false,

        -- Completion popup label
        label = '[tmux]',

        -- Trigger character
        trigger_characters = { '.' },

        -- Specify trigger characters for filetype(s)
        -- { filetype = { '.' } }
        trigger_characters_ft = {},

        -- Keyword patch mattern
        keyword_pattern = [[\w\+]],

        -- Capture full pane history
        -- `false`: show completion suggestion from text in the visible pane (default)
        -- `true`: show completion suggestion from text starting from the beginning of the pane history.
        --         This works by passing `-S -` flag to `tmux capture-pane` command. See `man tmux` for details.
        capture_history = false,
      }
    }
  }
})
```

## License

MIT
