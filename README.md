# Hexdump
A neovim plug-in for patching binaries using xxd to convert the binary to a 
hexdump and back. 

## Installation
[lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "MichaelTennant/nvim-hexdump", 
    name = "hexdump", 
    opts = {...}
}
```
Note that the opts args is required for lazy to load the module. If you don't
want to pass any options just do `opts = {}`.

### Options
By default, if hexdump is enabled and the file is written to, hexdump will 
automatically be disabled so the file binary is written to the file instead of 
xxd's file. This property can be disabled by setting the `disable_on_write` 
option to `false`.

**List of accepted options**
- `disable_on_write` (default value `true`)

e.g.
```lua
opts = {
    disable_on_write = false, 
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
- Make module get loaded from lazy even if opts arg isn't passed
- Custom linter while hexdump enabled
- Multiple hex code styles (i.e. 4d54, 4D54, 0x4d54, 0x4D54, 4d54h, 4D54h)
- Prevent user from modifying non-hex data in a file while enabled
- Prevent user from replacing data in a file with non-hex data while enabled
