local M = {}

function M.setup(opts)
    local self = {
        opts = opts or {},
        dumpedfiles = {}
    }

    -- Get if hexdump enabled
    local get_state = function()
        return self.dumpedfiles[vim.fn.expand("%:p")] == true
    end

    -- Enable/Disable hexdump
    -- returns true if hexdump state changes
    local set_state = function(new_dumped)
        if not self.isdumped and new_dumped then
            vim.cmd("%!xxd")
            self.dumpedfiles[vim.fn.expand("%:p")] = true
            print("Enabled hexdump.")
            return true

        elseif self.isdumped and not new_dumped then
            vim.cmd("%!xxd -r")
            self.dumpedfiles[vim.fn.expand("%:p")] = nil
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
    local toggle_state = function()
        return set_state(not get_state())
    end

    -- Make nvim user commands so users can run functions
    vim.api.nvim_create_user_command("HexdumpEnable", function() set_state(true) end, {nargs = 0})
    vim.api.nvim_create_user_command("HexdumpDisable", function() set_state(false) end, {nargs = 0})
    vim.api.nvim_create_user_command("HexdumpToggle", function() toggle_state() end, {nargs = 0})

    -- Keymap options
    if self.opts.keymap_enable_hexdump then
        vim.keymap.set_state("n", self.opts.keymap_enable_hexdump, function() set_state(true) end)
    end

    if self.opts.keymap_disable_hexdump then
        vim.keymap.set_state("n", self.opts.keymap_disable_hexdump, function() set_state(false) end)
    end

    if self.opts.keymap_toggle_state_hexdump then
        vim.keymap.set_state("n", self.opts.keymap_toggle_state_hexdump, function() toggle_state() end)
    end

    -- Other options
    -- `disable_on_write` true by default
    if self.opts.disable_on_write == nil then
        self.opts.disable_on_write = true
    end

    -- `forbid_insert_mode` true by default
    -- if self.opts.forbid_insert_mode == nil then
    --     self.opts.forbid_insert_mode = true
    -- end

    -- Hexdump Autocommands
    vim.api.nvim_create_augroup("Hexdump", {})

    -- Disable hexdump on save if `disable_on_write` true
    if self.opts.disable_on_write then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "Hexdump", 
            callback = function()
                if get_state() then
                    set_state(false)
                end
            end
        })
    end

    -- -- Switch user to replace mode when in insert mode if `forbid_insert_mode` true
    -- if self.opts.forbid_insert_mode then
    --     vim.api.nvim_create_autocmd("InsertChange,InsertEnter", {
    --         group = "Hexdump", 
    --         callback = function()
    --             if vim.cmd("echo v:insertmode") ~= "r" then
    --                 vim.cmd('')
    --             end
    --         end
    --     })
    -- end
end

return M
