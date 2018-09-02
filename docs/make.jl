using Documenter, Psycho

makedocs(
    format = :html,
    sitename = "Psycho.jl",
    modules = [Psycho]
)

deploydocs(
    repo = "github.com/neuropsychology/Psycho.jl.git",
    target = "build",
    julia  = "nightly",
    osname = "linux",
    deps   = nothing,
    make   = nothing
)