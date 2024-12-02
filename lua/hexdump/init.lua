local M = {}

function M.setup(opts)
    local opts = opts or {}

    local self = {
        isdumped = false
    }

    -- Is hexdump enabled?
    local get = function() {
        return self.isdumped
    }

    -- Enable/Disable hexdump
    -- returns true if hexdump state changes
    local set = function(new_dumped) {
        if not self.dumped and new_dumped then
            vim.cmd("%!xxd")
            self.isdumped = true
            print("Enabled hexdump.")
            return true

        elseif self.dumped and not new_dumped then
            vim.cmd("%!xxd -r")
            self.isdumped = false
            print("Disabled hexdump.")
            return true

        elseif not self.dumped then
            print("Cannot enable hexdump. Hexdump is already enabled.")
            return false

        else
            print ("Cannot disable hexdump. Hexdump is not enabled.")
            return false
        end
    }

    -- Toggle hexdump status
    -- returns true if success
    local toggle = function() {
        return set(not get())
    }

    -- Keymap options
    if opts.keymap_enable_hexdump then
        vim.keymap.set("n", opts.keymap_enable_hexdump, function() set(true) end)
    end

    if opts.keymap_disable_hexdump then
        vim.keymap.set("n", opts.keymap_disable_hexdump, function()) set(false) end)
    end

    if opts.keymap_toggle_hexdump then
        vim.keymap.set("n", opts.keymap_toggle_hexdump, function() toggle() end)
    end

    -- Interface/Instance methods
    return {
        get = get, 
        set = set, 
        toggle = toggle
    }
end

return M
