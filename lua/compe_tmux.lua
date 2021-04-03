--
-- compe-tmux
-- author: andersevenrud@gmail.com
-- license: MIT
--

local compe = require'compe'

--
-- Tmux implementation
--

local Tmux = {}

function Tmux.new()
  local self = setmetatable({}, { __index = Tmux })
  self.has_tmux = vim.fn.executable('tmux')
  self.is_tmux = os.getenv('TMUX')
  return self
end

function Tmux.is_enabled(self)
    return self.has_tmux and self.is_tmux
end

function Tmux.get_current_pane()
    return os.getenv('TMUX_PANE')
end

function Tmux.get_panes(self, current_pane)
    local h = io.popen('tmux list-panes $LISTARGS -F \'#{pane_active}#{window_active}-#{session_id} #{pane_id}\'')
    local data = h:read('*all')
    local result = {}

    for p in string.gmatch(data, '%%%d+') do
        if current_pane ~= p then
            table.insert(result, p)
        end
    end

    return result
end

function Tmux.get_pane_data(self, pane)
    local h = nil
    if io.popen('tmux capture-pane -p') == nil then
        h = io.popen('tmux capture-pane -t {} ' .. pane .. ' && tmux show-buffer && tmux delete-buffer')
    else
        h = io.popen('tmux capture-pane -p -t ' .. pane)
    end

    if h ~= nil then
        return h:read('*all')
    end

    return nil
end

function Tmux.get_completion_items(self, current_pane, input)
    local panes = self:get_panes(current_pane)
    local result = {}

    for _, p in ipairs(panes) do
        local data = self:get_pane_data(p)
        if data ~= nil then
            for word in string.gmatch(data, '[%w_:/.%-~]+') do
                if word:lower():match(input:lower()) then
                    table.insert(result, {
                        word = word:gsub('[:.]+$', '')
                    })
                end
            end
        end
    end

    return result
end

function Tmux.complete(self, input)
    if not self:is_enabled() then
        return nil
    end

    local current_pane = self:get_current_pane()
    if not current_pane then
        return nil
    end

    return self:get_completion_items(current_pane, input)
end

--
-- Compe implementation
--

local Source = {}

function Source.new()
  local self = setmetatable({}, { __index = Source })
  self.tmux = Tmux.new()
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

return Source.new()
