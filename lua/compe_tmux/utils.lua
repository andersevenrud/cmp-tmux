--
-- compe-tmux
-- url: https://github.com/andersevenrud/compe-tmux
-- author: andersevenrud@gmail.com
-- license: MIT
--

local Utils = {}

Utils.read_command = function(cmd)
    local h = io.popen(cmd)

    if h ~= nil then
        local data = h:read('*all')

        h:close()

        return data
    end

    return nil
end

return Utils
