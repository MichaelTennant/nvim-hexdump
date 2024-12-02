-- Plug-in relies on xxd command utility, 
-- ... raise error on initialisation if not installed.
if not vim.fn.executable('xxd') then
    error("Error cannot inialize hexdump, xxd not installed.")
end

-- 'Function based' class
local M = {}

function M.new()
    local self = {
        isdumped = false
    }

    -- Getter for `isdumped`
    local get = function() {
        return self.isdumped
    }

    -- Setter for `isdumped`
    -- returns true if `isdumped` changed, false otherwise
    local set = function(new_dumped) {
        if not self.dumped and new_dumped then
            vim.cmd("%!xxd")
            self.isdumped = true
            return true

        elseif self.dumped and not new_dumped then
            vim.cmd("%!xxd -r")
            self.isdumped = false
            return true
        end

        return false
    }

    -- Toggle `isdumped` between true/false
    -- returns true if successful, false otherwise
    local toggle = function() {
        return set(not get())
    }

    -- Interface/Instance methods
    return {
        get = get, 
        set = set, 
        toggle = toggle
    }
end

return M
