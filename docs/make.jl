using Documenter, Psycho

makedocs(
    format = :html,
    sitename = "GLM",
    modules = [GLM]
)

deploydocs(
    repo = "github.com/neuropsychology/Psycho.jl.git",
    julia = "1.0"
)