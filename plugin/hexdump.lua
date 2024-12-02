-- Hexdump requirements
if vim.fn.has("nvim-0.7.0") ~= 1 then
    vim.api.nvim_error_writeln("Hexdump plug-in requires at least nvim-0.7.0.")
end

if not vim.fn.executable('xxd') then
    vim.api.nvim_err_writeln("Hexdump plug-in requires xxd command utility.")
end
