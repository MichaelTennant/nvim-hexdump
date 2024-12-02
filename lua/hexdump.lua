local M = {}

function M.setup(opts)
    local opts = opts or {}

    local self = {
        isdumped = false
    }

    -- Is hexdump enabled?
    local get = function()
        return self.isdumped
    end

    -- Enable/Disable hexdump
    -- returns true if hexdump state changes
    local set = function(new_dumped)
        if not self.isdumped and new_dumped then
            vim.cmd("%!xxd")
            self.isdumped = true
            print("Enabled hexdump.")
            return true

        elseif self.isdumped and not new_dumped then
            vim.cmd("%!xxd -r")
            self.isdumped = false
            print("Disabled hexdump.")
            return true

        elseif not self.isdumped then
            print("Cannot enable hexdump. Hexdump is already enabled.")
            return false

        else
            print("Cannot disable hexdump. Hexdump is not enabled.")
            return false
        end
    end

    -- Toggle hexdump status
    -- returns true if success
    local toggle = function()
        return set(not get())
    end

    -- Make nvim user commands so users can run functions
    vim.api.nvim_create_user_command("HexdumpEnable", function() set(true) end, {nargs = 0})
    vim.api.nvim_create_user_command("HexdumpDisable", function() set(false) end, {nargs = 0})
    vim.api.nvim_create_user_command("HexdumpToggle", function() toggle() end, {nargs = 0})

    -- Keymap options
    if opts.keymap_enable_hexdump then
        vim.keymap.set("n", opts.keymap_enable_hexdump, function() set(true) end)
    end

    if opts.keymap_disable_hexdump then
        vim.keymap.set("n", opts.keymap_disable_hexdump, function() set(false) end)
    end

    if opts.keymap_toggle_hexdump then
        vim.keymap.set("n", opts.keymap_toggle_hexdump, function() toggle() end)
    end

    -- Other options
    -- `disable_on_write` true by default
    if opts.disable_on_write == nil then
        opts.disable_on_write = true
    end

    -- Disable hexdump on save if `disable_on_write` true
    if opts.disable_on_write then
        vim.api.nvim_create_augroup("Hexdump", {})
        vim.api.nvim_create_autocmd("DisableHexdump", {
            callback = function()
                if get() then
                    set(false)
                end
            end
        })
    end
end

return M
