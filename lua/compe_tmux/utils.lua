--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: andersevenrud@gmail.com
-- license: MIT
--

local Utils = {}
local compe_config = require'compe.config'

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
    local source = {}
    local c = compe_config.get()

    if c ~= nil then
        source = c.source.tmux and c.source.tmux or {}
    end

    return vim.tbl_extend('force', {
        all_panes = false,
        kind = 'Text'
    }, source)
end

return Utils
