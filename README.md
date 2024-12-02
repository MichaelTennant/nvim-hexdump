# Hexdump
A neovim plug-in for patching binaries using xxd to convert the binary to a hexdump and back. 

By default, in the event hexdump is enabled and the file is written to, hexdump will automatically be disabled so the file binary is written to the file instead of xxd's file. This property can be disabled by setting the `disable_on_write` option to `false`.

## Installation
[lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "MichaelTennant/nvim-hexdump", 
    name = "hexdump", 
    opts = {...}
}
```
### Options
- `keymap_enable_hexdump`
- `keymap_disable_hexdump`
- `keymap_toggle_hexdump`
- `disable_on_write` (default value `true`)

e.g.
```lua
opts = {
    keymap_toggle_hexdump = "<leader>th", 
    disable_on_write = false
}
```

### Requires
- Neovim 0.7.0 or later
- xxd

## Commands
- `HexdumpEnable`
- `HexdumpDisable`
- `HexdumpToggle`
