--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: andersevenrud@gmail.com
-- license: MIT
--

local compe = require'compe'
local compe_config = require'compe.config'
local Tmux = require'compe_tmux.tmux'

local Source = {}

function Source.new()
    local source = {}
    local c = compe_config.get()

    if c ~= nil then
        source = c.source.tmux and c.source.tmux or {}
    end

    local self = setmetatable({}, { __index = Source })

    self.tmux = Tmux.new({
        all_panes = source.all_panes == true,
        kind = source.kind or 'Text'
    })
    return self
end

function Source.get_metadata(self)
    return {
        priority = 100,
        dup = 0,
        menu = '[tmux]'
    }
end

function Source.determine(self, context)
    return compe.helper.determine(context)
end

function Source.complete(self, args)
    local items = self.tmux:complete(args.input)
    if items == nil then
        return args.abort()
    end

    args.callback({
        incomplete = true,
        items = items
    })
end

return Source
