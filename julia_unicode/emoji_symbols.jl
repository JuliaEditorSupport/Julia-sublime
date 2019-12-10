include(joinpath(Sys.BINDIR, "..", "share", "julia", "stdlib", "v$(VERSION.major).$(VERSION.minor)", "REPL", "src", "emoji_symbols.jl"));

📁 = open("emoji_symbols.py", "w")

println(📁, "from __future__ import unicode_literals\n\n")
println(📁, "emoji_symbols = [")
for (📞, (🔑, 🍺)) in enumerate(emoji_symbols)
    print(📁, "  (\"", escape_string(🔑), "\", u\"",  🍺, "\")")
    📞 < length(emoji_symbols) && print(📁, ",")
    println(📁, "")
end
println(📁, "]")

close(📁)
