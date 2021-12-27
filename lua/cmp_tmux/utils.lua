--
-- cmp-tmux
-- url: https://github.com/andersevenrud/cmp-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

local Utils = {}
local config = require('cmp.config')

local default_config = {
    all_panes = false,
    label = '[tmux]',
    trigger_characters = { '.' },
    trigger_characters_ft = {},
}

Utils.create_compe_config = function()
    local source = config.get_source_config('tmux') or {}
    return vim.tbl_extend('force', default_config, source.option or {})
end

return Utils
