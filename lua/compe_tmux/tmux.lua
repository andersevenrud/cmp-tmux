--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

local utils = require('compe_tmux.utils')
local Tmux = {}

function Tmux.new(config)
    local self = setmetatable({}, { __index = Tmux })
    self.has_tmux = vim.fn.executable('tmux') == 1
    self.is_tmux = os.getenv('TMUX') ~= nil
    self.config = config
    return self
end

function Tmux.is_enabled(self)
    return self.has_tmux and self.is_tmux
end

function Tmux.get_current_pane()
    return os.getenv('TMUX_PANE')
end

function Tmux.get_panes(self, current_pane)
    local result = {}

    local cmd = "tmux list-panes -F '#{pane_id}'"
    if self.config.all_panes then
        cmd = cmd .. ' -a'
    end

    local data = utils.read_command(cmd)
    if data ~= nil then
        for p in string.gmatch(data, '%%%d+') do
            if current_pane ~= p then
                table.insert(result, p)
            end
        end
    end

    return result
end

function Tmux.get_pane_data(self, pane)
    return utils.read_command('tmux capture-pane -p -t ' .. pane)
end

function Tmux.get_completion_items(self, current_pane, input)
    local panes = self:get_panes(current_pane)
    local result = {}
    local input_lower = input:lower()

    for _, p in ipairs(panes) do
        local data = self:get_pane_data(p)
        if data ~= nil then
            -- match not only full words, but urls, paths, etc.
            for word in string.gmatch(data, '[%w%d_:/.%-~]+') do
                local word_lower = word:lower()

                if word_lower:match(input_lower) then
                    local clean_word = word:gsub('[:.]+$', '')
                    if #clean_word > 0 then
                        result[clean_word] = true

                        -- but also isolate the words from the result
                        for sub_word in string.gmatch(word, '[%w%d]+') do
                            result[sub_word] = true
                        end
                    end
                end
            end
        end
    end

    return vim.tbl_keys(result)
end

function Tmux.complete(self, input)
    if self:is_enabled() then
        local current_pane = self:get_current_pane()
        -- if not current_pane then
        --     return nil
        -- end

        return self:get_completion_items(current_pane, input)
    end

    return nil
end

return Tmux
