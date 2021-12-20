--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

local utils = require('compe_tmux.utils')
local Tmux = require('compe_tmux.tmux')

local source = {}

source.new = function()
    local self = setmetatable({}, { __index = source })
    local config = utils.create_compe_config()
    self.tmux = Tmux.new(config)
    self.config = config
    return self
end

source.get_debug_name = function()
    return 'tmux'
end

function source:is_available()
    return self.tmux:is_enabled()
end

function source:get_keyword_pattern()
    return [[\w\+]]
end

function source:get_trigger_characters()
    local ft = vim.bo.filetype
    local tcft = self.config.trigger_characters_ft[ft]
    return tcft or self.config.trigger_characters
end

function source:complete(request, callback)
    local word = string.sub(request.context.cursor_before_line, request.offset)
    local words = self.tmux:complete(word)
    if words == nil then
        return callback()
    end

    local items = vim.tbl_map(function(w)
        return {
            word = w,
            label = w,
            labelDetails = {
                detail = self.config.label,
            },
        }
    end, words)

    callback(items)
end

function source:resolve(completion_item, callback)
    callback(completion_item)
end

function source:execute(completion_item, callback)
    callback(completion_item)
end

return source
