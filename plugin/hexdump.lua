
-- Plug-in relies on xxd command utility, 
-- ... raise error on initialisation if not installed.
if not vim.fn.executable('xxd') then
    vim.api.nvim_err_writeln("Error cannot inialize hexdump, xxd not installed.")
end

print("Hello from plugin.hexdump!")
