--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

local utils = require'compe_tmux.utils'
local Tmux = require'compe_tmux.tmux'

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
  return { '.' }
end

function source:complete(request, callback)
    local word = string.sub(request.context.cursor_before_line, request.offset)
    local words = self.tmux:complete(word)
    local items = vim.tbl_map(function(word)
        return {
            word = word,
            label = word,
            labelDetails = {
                detail = self.config.label
            }
        }
    end, words)
    if items == nil then
        return callback()
    end

    callback(items)
end

function source:resolve(completion_item, callback)
    callback(completion_item)
end

function source:execute(completion_item, callback)
    callback(completion_item)
end

return source
