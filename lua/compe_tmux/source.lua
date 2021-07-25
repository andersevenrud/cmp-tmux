--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

local compe = require'compe'
local utils = require'compe_tmux.utils'
local Tmux = require'compe_tmux.tmux'

local Source = {}

function Source.new()
    local self = setmetatable({}, { __index = Source })
    local config = utils.create_compe_config()
    self.tmux = Tmux.new(config)
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
