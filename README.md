# Julia-sublime

Julia language support for Sublime Text 4 or above

- Syntax highlighting
- Unicode tab completion (like the [REPL](http://docs.julialang.org/en/latest/manual/interacting-with-julia/#tab-completion))
- Auto-indentation
- Snippets


## Installation

If you haven't already, [install Package Control](https://packagecontrol.io/installation), then select `Julia` from the `Package Control: Install Package` dropdown list in the Command Palette.

### Manual installation

If you want more control over what you pull down, or if you'd like to submit a PR, you coould clone the repository directly.

```
# on a Mac
cd "$HOME/Library/Application Support/Sublime Text/Packages"
# on Linux
cd $HOME/.config/sublime-text/Packages
# on Windows (PowerShell)
cd "$env:appdata\Sublime Text\Packages\"

git clone git@github.com:JuliaEditorSupport/Julia-sublime.git Julia
```


## Technical details

### Sublime Text version support

This package should be only used in Sublime Text 4 or above. Sublime Text 3
support is deprecated. You are still able to install older version (0.9.0) of Julia
from Package Control or from GitHub release https://github.com/juliaeditorsupport/julia-sublime/releases.

### Custom colors

The default colors are chosen to satisfy most people. However, you might prefer to highlight macros, types, function calls etc. in different colors. This can be achieved by modifying the color associated with the syntax scope, such as `variable.macro`, in your color scheme. Use the shortcut `ctrl+shift+alt+p` or `cmd+alt+p` (macOS) to find out what syntax scope is applied to a certain character.


## Contributing

- Run the `build` command by hitting `ctrl+shift+b` or `cmd+shift+b`(macOS) on the [`syntax_test_julia.jl`](https://github.com/JuliaEditorSupport/Julia-sublime/blob/master/syntax_test_julia.jl) file.
- Keep the tests updated. Fixed issues should generally get a test.
