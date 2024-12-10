This is a modularized kickstart.nvim configuration. Current goals are finishing my math note-taking setup in Obsidian and LaTeX.
```txt
├── ftplugin
│   └── lua.lua
├── init.lua
├── lazy-lock.json
└── lua
    ├── custom
    │   ├── cmp_config.lua
    │   └── luasnip_config.lua
    ├── main
    │   ├── autocommand.lua
    │   ├── helper_function.lua
    │   ├── init.lua
    │   ├── options.lua
    │   └── remap.lua
    ├── plugin
    │   ├── appearance.lua
    │   ├── git.lua
    │   ├── latex.lua
    │   ├── lsp.lua
    │   ├── obsidian.lua
    │   ├── other.lua
    │   ├── speed.lua
    │   ├── telescope.lua
    │   └── treesitter.lua
    └── snippets
        ├── all.lua
        └── mathzone_funcion.lua
```
`init.lua` - disables neotree and contains: `lazy.nvim` package manager config, language switching config https://github.com/Wansmer/langmapper.nvim

**Main** - Vanilla nvim configuration.<br>
**Plugin** - `lazy.nvim`'s plugin spec.<br>
**Custom** - some long plugin configuration that I've extracted into separate files, I then require them in the plugin spec. For example, I have `function() require("custom.cmp_config") end` in `lsp.lua` in `nvim-cmp` autocompletion config.
