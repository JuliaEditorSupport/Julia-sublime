# Julia-sublime

Julia language support for Sublime Text 2/3.

- Syntax highlighting
- Unicode tab completion (like the [REPL](http://docs.julialang.org/en/latest/manual/interacting-with-julia/#tab-completion))
- Auto-indentation
- Snippets


## Installation

If you haven't already, [install Package Control](https://packagecontrol.io/installation), then select `Julia` from the `Package Control: Install Package` dropdown list in the Command Palette.

### Manual installation

Clone the repository into `~/.config/sublime-text-3/Packages/`. (The path may be different depending on OS and version.)


## Example

![Highlight example](https://github.com/JuliaEditorSupport/Julia-sublime/blob/master/highlight-example.png)

_Don't hesitate to open an issue if something looks wrong or if you think that something can be done better._


## Technical details

### Sublime Text version support

Sublime Text 3 Build 3103 or later will use `Julia.sublime-syntax` which provides superior highlighting. For backward compatibility `Julia.tmLanguage` acts as fallback.

### Custom colors

The default colors are chosen to satisfy most people. However, you might prefer to highlight types and function calls in different colors. This can be achieved by modifying the color associated with the syntax scope `variable.function` in your color scheme. Similarly for macros etc. Use the shortcut `ctrl+shift+alt+p` to find out what syntax scope is applied to a certain character.


## Contributing

- Run the `build` command (`ctrl+shift+b`) on the [`syntax_test_julia.jl`](https://github.com/JuliaEditorSupport/Julia-sublime/blob/master/syntax_test_julia.jl) file.
- Keep the tests updated. Fixed issues should generally get a test.
