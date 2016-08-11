include(joinpath(JULIA_HOME, "..", "share", "julia", "base", "latex_symbols.jl"));

φ = open("latex_symbols.py", "w")

println(φ, "latex_symbols = [")
for (ω, (α, β)) in enumerate(latex_symbols)
    print(φ, "(\"", escape_string(α), "\", \"",  β, "\")")
    ω < length(latex_symbols) && print(φ, ",")
    println(φ, "")
end
println(φ, "]")

close(φ)
