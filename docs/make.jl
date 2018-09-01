using Documenter, Psycho

makedocs(
    format = :html,
    sitename = "Psycho.jl",
    modules = [Psycho]
)

deploydocs(
    repo = "github.com/neuropsychology/Psycho.jl.git",
    target = "build",
    deps   = nothing,
    make   = nothing
)