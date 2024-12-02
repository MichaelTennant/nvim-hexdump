# Hexdump
A neovim plug-in for patching binaries using xxd to convert the binary to a hexdump and back. 

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
By default, if hexdump is enabled and the file is written to, hexdump will automatically be disabled so the file binary is written to the file instead of xxd's file. This property can be disabled by setting the `disable_on_write` option to `false`.

**List of accepted options**
- `keymap_enable_hexdump`
- `keymap_disable_hexdump`
- `keymap_toggle_hexdump`
- `disable_on_write` (default value `true`)

e.g.
```lua
opts = {
    keymap_toggle_hexdump = "<leader>th", 
    forbid_insert_mode = false
}
```

### Requires
- Neovim 0.7.0 or later
- xxd

## Commands
- `HexdumpEnable`
- `HexdumpDisable`
- `HexdumpToggle`

## TODO
- Prevent user from modifying non-hex data in a file while enabled
- Prevent user from replacing data in a file with non-hex data while enabled
- Multiple hex code styles (i.e. 4d54, 4D54, 0x4d54, 0x4D54, 4d54h, 4D54h)
