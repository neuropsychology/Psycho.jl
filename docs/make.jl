using Documenter, Psycho

makedocs(
    format = :html,
    sitename = "Psycho",
    modules = [Psycho]
)

deploydocs(
    repo = "github.com/neuropsychology/Psycho.jl.git",
    julia = "release"
)