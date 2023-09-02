--
-- cmp-tmux
-- url: https://github.com/andersevenrud/cmp-tmux
-- author: Anders Evenrud <andersevenrud@gmail.com>
-- license: MIT
--

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

    local handle = io.popen(cmd)
    if handle ~= nil then
        local data = handle:read('*all')
        if data ~= nil then
            for p in string.gmatch(data, '%%%d+') do
                if current_pane ~= p then
                    table.insert(result, p)
                end
            end
        end

        handle:close()
    end

    return result
end

function Tmux.create_pane_data_job(self, pane, on_data, on_exit)
    local cmd = { 'tmux', 'capture-pane', '-p', '-t', pane }
    if self.config.capture_history then
        table.insert(cmd, '-S-')
    end

    return vim.fn.jobstart(cmd, {
        on_exit = on_exit,
        on_stderr = nil,
        on_stdout = function(_, data)
            local result = table.concat(data, '\n')
            if #result > 0 then
                on_data(result)
            end
        end,
    })
end

function Tmux.get_completion_items(self, current_pane, input, callback)
    local panes = self:get_panes(current_pane)
    local input_lower = input:lower()
    local remainder = #panes
    local result = {}

    if remainder == 0 then
        return callback(nil)
    end

    for _, p in ipairs(panes) do
        self:create_pane_data_job(p, function(data)
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
        end, function()
            remainder = remainder - 1

            if remainder == 0 then
                callback(vim.tbl_keys(result))
            end
        end)
    end
end

function Tmux.complete(self, input, callback)
    if self:is_enabled() then
        local current_pane = self:get_current_pane()
        self:get_completion_items(current_pane, input, callback)
    else
        callback(nil)
    end
end

return Tmux
