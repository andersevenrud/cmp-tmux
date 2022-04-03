--
-- cmp-tmux
-- url: https://github.com/andersevenrud/cmp-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

local config = require('cmp.config')
local Tmux = require('cmp_tmux.tmux')

local source = {}

local default_config = {
    panes = Tmux.Panes.CURRENT,
    label = '[tmux]',
    trigger_characters = { '.' },
    trigger_characters_ft = {},
}

local function create_config()
    local source_config = config.get_source_config('tmux') or {}
    return vim.tbl_extend('force', default_config, source_config.option or {})
end

source.new = function()
    local self = setmetatable({}, { __index = source })
    self.config = create_config()
    self.tmux = Tmux.new(self.config)
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

    self.tmux:complete(word, function(words)
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
    end)
end

function source:resolve(completion_item, callback)
    callback(completion_item)
end

function source:execute(completion_item, callback)
    callback(completion_item)
end

return source
