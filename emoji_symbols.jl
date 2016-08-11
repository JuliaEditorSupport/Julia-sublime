include(joinpath(JULIA_HOME, "..", "share", "julia", "base", "emoji_symbols.jl"));

📁 = open("emoji_symbols.py", "w")

println(📁, "emoji_symbols = [")
for (📞, (🔑, 🍺)) in enumerate(emoji_symbols)
    print(📁, "(\"", escape_string(🔑), "\", \"",  🍺, "\")")
    📞 < length(emoji_symbols) && print(📁, ",")
    println(📁, "")
end
println(📁, "]")

close(📁)
