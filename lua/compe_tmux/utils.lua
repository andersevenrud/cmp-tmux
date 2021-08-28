--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

local Utils = {}
local config = require'cmp.config'

local default_config = {
    all_panes = false,
    label = '[tmux]'
}

Utils.read_command = function(cmd)
    local h = io.popen(cmd)

    if h ~= nil then
        local data = h:read('*all')

        h:close()

        return data
    end

    return nil
end

Utils.create_compe_config = function()
    local source = config.get_source_option('tmux') or {}
    return vim.tbl_extend('force', default_config, source)
end

return Utils
