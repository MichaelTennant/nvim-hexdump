-- Hexdump requirements
if not vim.fn.executable('xxd') then
    vim.api.nvim_err_writeln("Hexdump plug-in requires xxd command utility.")
end
