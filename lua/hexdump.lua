local M = {}

function M.setup()
    print("setup start")
    local self = {
        dumpedfiles = {}
    }

    -- Default Options
    opts = {}

    -- Prevents user writing hexdump of file instead of file binary to file.
    -- Defaults true.
    if opts.disable_on_write == nil then
        opts.disable_on_write = true
    end

    -- Get if hexdump enabled
    local get_state = function()
        return self.dumpedfiles[vim.fn.expand("%:p")] == true
    end

    -- Enable/Disable hexdump
    -- returns true if hexdump state changes
    local set_state = function(new_dumped)
        if not get_state() and new_dumped then
            vim.cmd("silent %!xxd")
            self.dumpedfiles[vim.fn.expand("%:p")] = true
            print("Enabled hexdump.")
            return true

        elseif get_state() and not new_dumped then
            vim.cmd("silent %!xxd -r")
            self.dumpedfiles[vim.fn.expand("%:p")] = nil
            print("Disabled hexdump.")
            return true

        elseif new_dumped then
            print("Cannot enable hexdump. Hexdump is already enabled.")
            return false

        else
            print("Cannot disable hexdump. Hexdump is not enabled.")
            return false
        end
    end

    -- Toggle hexgdump status
    -- returns true if success
    local toggle_state = function()
        return set_state(not get_state())
    end

    -- Make nvim user commands so users can run functions
    vim.api.nvim_create_user_command("HexdumpEnable", 
        function() set_state(true) end, {nargs = 0}
    )
    vim.api.nvim_create_user_command("HexdumpDisable", 
        function() set_state(false) end, {nargs = 0}
    )
    vim.api.nvim_create_user_command("HexdumpToggle", 
        function() toggle_state() end, {nargs = 0}
    )

    -- Hexdump Autocommands
    vim.api.nvim_create_augroup("Hexdump", {})

    -- Disable hexdump on save if `disable_on_write` true
    if opts.disable_on_write then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "Hexdump", 
            callback = function() 
                if get_state() then set_state(false) end
            end
        })
    end

    print("setup end")
end

return M
